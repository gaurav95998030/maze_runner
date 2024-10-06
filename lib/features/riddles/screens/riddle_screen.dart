
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:maze_runner/features/constants/screens/endling_video_splash_screen.dart';
import 'package:maze_runner/features/riddles/providers/riddles_provider.dart';
import 'package:maze_runner/features/riddles/widgets/show_riddle.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../modals/riddle_modal.dart';

class RiddleScreen extends StatefulWidget {
  const RiddleScreen({super.key});

  @override
  State<RiddleScreen> createState() => _RiddleScreenState();
}








class _RiddleScreenState extends State<RiddleScreen> {

 late SharedPreferences prefs;
 int currentRiddleIndex = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    loadCurrentIndex();
  }


  void loadCurrentIndex() async{
     prefs = await SharedPreferences.getInstance();

     currentRiddleIndex  = prefs.getInt('currentIndex')??0;
     if(currentRiddleIndex==7) {

       Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx)=>const VideoSplashScreen()));


       return;
     }
     print("gaurav $currentRiddleIndex");

     setState(() {

     });

  }

// Save an integer value to 'counter' key.



  void handleNextClick() async{
    print(currentRiddleIndex);
    if(currentRiddleIndex==7) {

      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx)=>const VideoSplashScreen()));


      return;
    }

    if(currentRiddleIndex<7){


      setState(()  {
        currentRiddleIndex=currentRiddleIndex+1;

      });

      await prefs.setInt('currentIndex', currentRiddleIndex);
    }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Consumer(

        builder: (context,ref,child) {

          List<RiddleResponse> riddles = ref.watch(riddleProvider);

         return ShowRiddle(riddle: riddles[currentRiddleIndex], handleNextClick:handleNextClick ,);
        }
      ),
    );
  }
}
