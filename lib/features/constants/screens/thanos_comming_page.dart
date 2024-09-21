import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:maze_runner/features/auth/modal/user_modal.dart';
import 'package:maze_runner/features/auth/providers/user_provider.dart';
import 'package:maze_runner/features/riddles/providers/riddles_provider.dart';

import '../../riddles/screens/riddle_screen.dart';

class ThanosComingPage extends StatelessWidget {
  const ThanosComingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image with placeholder
          Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/thanos.jpg"),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.6), // Dark overlay for readability
                      BlendMode.darken,
                    ),
                  ),
                ),
                child: FadeInImage(
                  placeholder: AssetImage('assets/images/dark_placeholder.png'), // Dark placeholder image
                  image: AssetImage("assets/images/thanos.jpg"),
                  fit: BoxFit.cover,
                  fadeInDuration: Duration(milliseconds: 500),
                  imageErrorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.black, // If image fails to load, show a solid black background
                    );
                  },
                ),
              ),
          ),

          // Main content overlaying the image
          Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                   Consumer(
                     builder: (context,ref,child) {
                       LoginResponse? state = ref.watch(teamProvider);

                       if(state!=null){
                         return Text("Hello Team ${state.team.teamname}",style: const TextStyle(color:Colors.yellow),);
                       }else{
                         return const Text("Hello Team");
                       }

                     }
                   ),
                  const Text(
                    "Thanos is Coming for You...",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.redAccent,
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5,
                      shadows: [
                        Shadow(
                          blurRadius: 10.0,
                          color: Colors.black,
                          offset: Offset(3, 3),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),

                  // Challenge to solve riddles
                  Text(
                    "Be a Mystery Solver and Save the World!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                      shadows: [
                        Shadow(
                          blurRadius: 10.0,
                          color: Colors.black,
                          offset: Offset(2, 2),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),

                  // Brief game description
                  Text(
                    "Six Infinity Stones are hidden, each protected by a riddle. Only a true mystery solver can defeat Thanos and protect the universe.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.grey[300],
                      fontSize: 18,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 60),

                  // Start button
                  Consumer(
                    builder: (context,ref,child) {
                      return ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.redAccent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          padding: const EdgeInsets.symmetric(
                            vertical: 16,
                            horizontal: 32,
                          ),
                        ),
                        onPressed: () async {
                        bool res = await ref.read(riddleProvider.notifier).loadRiddles();


                        if(res){
                          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx)=>RiddleScreen()));
                        }
                        },
                        child:  const Text(
                          'Start Your Quest',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
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
    );
  }
}
