import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:maze_runner/features/auth/modal/user_modal.dart';
import 'package:maze_runner/features/auth/providers/user_provider.dart';

class RiddleCompleteScreen extends StatefulWidget {
  const RiddleCompleteScreen({super.key});

  @override
  State<RiddleCompleteScreen> createState() => _RiddleCompleteScreenState();
}

class _RiddleCompleteScreenState extends State<RiddleCompleteScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Background Image with dark overlay
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: const AssetImage("assets/images/thanos.jpg"),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.6), // Dark overlay for readability
                    BlendMode.darken,
                  ),
                ),
              ),
              // Fade-in image with error handling
              child: FadeInImage(
                placeholder: const AssetImage('assets/images/dark_placeholder.png'),
                image: const AssetImage("assets/images/thanos.jpg"),
                fit: BoxFit.cover,
                fadeInDuration: const Duration(milliseconds: 500),
                imageErrorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.black, // Fallback in case of image load failure
                  );
                },
              ),
            ),
          ),

          // Main content centered
           Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Total Score Text

                Consumer(
                  builder: (context,ref,child) {
                    LoginResponse? loginRes= ref.watch(teamProvider);
                    return  Text(
                      "Your Total Score: ${loginRes!.team.teamscore}",
                      style: TextStyle(
                        fontSize: 28,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    );
                  }
                ),
                SizedBox(height: 20),

                // Suspense message
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    "Let's wait for the result. Were you able to save the world?",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.yellowAccent,
                      fontStyle: FontStyle.italic,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 40),

                // Button to go back or try again

              ],
            ),
          ),
        ],
      ),
    );
  }
}
