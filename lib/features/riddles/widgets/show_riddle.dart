import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:maze_runner/features/auth/providers/user_provider.dart';
import 'package:maze_runner/features/riddles/modals/riddle_modal.dart';
import 'package:maze_runner/features/riddles/providers/next_riddle_loader_provider.dart';
import 'package:maze_runner/features/riddles/providers/riddles_provider.dart';
import 'package:maze_runner/utils/show_snack_bar_msg.dart';

class ShowRiddle extends StatefulWidget {
  final RiddleResponse riddle;

  final Function() handleNextClick;

  const ShowRiddle({required this.riddle, required this.handleNextClick, super.key});

  @override
  State<ShowRiddle> createState() => _ShowRiddleState();
}

class _ShowRiddleState extends State<ShowRiddle> {



  TextEditingController answerController = TextEditingController();

  List<String> images = ["1.jpg", "2.jpg", "3.jpg", "4.jpg", "5.jpg", "6.jpg", "7.jpg","8.jpg","9.jpg","10.jpg", "11.jpg"];

  int randomNumber = 0;
  var random = Random();
  @override
  void didUpdateWidget(covariant ShowRiddle oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    if(oldWidget.riddle.riddleId!=widget.riddle.riddleId){
       randomNumber = random.nextInt(10)+1;
      answerController.text="";
    }
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    answerController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.black, Colors.redAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Stack(
          children: [
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/$randomNumber.jpg"),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.6), // Dark overlay for readability
                      BlendMode.darken,
                    ),
                  ),
                ),
                child: FadeInImage(
                  placeholder: const AssetImage('assets/images/dark_placeholder.png'), // Dark placeholder image
                  image:  AssetImage("assets/images/$randomNumber.jpg"),
                  fit: BoxFit.cover,
                  fadeInDuration: const Duration(milliseconds: 500),
                  imageErrorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.black, // If image fails to load, show a solid black background
                    );
                  },
                ),
              ),
            ),
            Center(
              child: Container(
                padding: const EdgeInsets.all(20),
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.95),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 12,
                      offset: Offset(0, 6),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Consumer(
                      builder: (context,ref,child) {
                        int score = ref.watch(teamProvider)!.team.teamscore;
                        return Text(score.toString());
                      }
                    ),
                    Text(
                      'Riddle:',
                      style: TextStyle(
                        fontFamily: 'Marvel',
                        fontSize: 32,
                        color: Colors.red[900],
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      widget.riddle.riddle.description,
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: answerController,
                            decoration: InputDecoration(
                              labelText: 'Your Answer',
                              labelStyle: TextStyle(color: Colors.red[900]),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: Colors.red[900]!),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: Colors.red[900]!),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Consumer(
                      builder: (context,ref,child) {
                        return ElevatedButton(
                          onPressed: () async{


                            if(answerController.text.trim().isEmpty){
                              ShowSnackBarMSg.showMsg("Your Answer cannot be empty!!!");
                              return;
                            }




                           String res = await ref.read(riddleProvider.notifier).checkRiddle(widget.riddle, answerController.text.trim());

                           if(res=="already solved"){
                             widget.handleNextClick();
                             return;

                           }

                           List<String> responseList = res.split(" ");

                           if(responseList[0]=="correct"){
                             print(responseList[2]);

                             ref.read(teamProvider.notifier).updateTeamScore(int.tryParse(responseList[2])!);

                             widget.handleNextClick();

                             ShowSnackBarMSg.showMsg("Correct Answer!! Moving to next riddle!!");


                             return ;

                           }





                           if(res == "No more attempts are allowed for this riddle. You have reached the maximum attempts."){

                             ShowSnackBarMSg.showMsg("$res Moving to next riddle!!");
                             await Future.delayed(const Duration(seconds: 2));


                             widget.handleNextClick();
                            }



                           ShowSnackBarMSg.showMsg(res);



                            // widget.handleNextClick();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red[900],
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child:  Consumer(
                            builder: (context,ref,child) {
                              bool isLoading = ref.watch(nextRiddleLoaderProvider);
                              return Text(
                                isLoading?"Please wait":'Next',
                                style: TextStyle(fontSize: 20, color: Colors.white),
                              );
                            }
                          ),
                        );
                      }
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
