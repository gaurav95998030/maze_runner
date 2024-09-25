import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:maze_runner/features/auth/modal/user_modal.dart';
import 'package:maze_runner/features/auth/providers/user_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RiddleCompleteScreen extends StatefulWidget {
  const RiddleCompleteScreen({super.key});

  @override
  State<RiddleCompleteScreen> createState() => _RiddleCompleteScreenState();
}

class _RiddleCompleteScreenState extends State<RiddleCompleteScreen> {
  @override
  void initState() {
    super.initState();

    markAsCompleted();
  }



  void markAsCompleted() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setBool("isCompleted", true);
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
                    Colors.black.withOpacity(0.7), // Darker overlay for a more cinematic look
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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Total Score Text
                Consumer(
                  builder: (context, ref, child) {
                    LoginResponse? loginRes = ref.watch(teamProvider);
                    return Text(
                      "Your Total Score: ${loginRes!.team.teamscore}",
                      style: const TextStyle(
                        fontSize: 32, // Larger for better emphasis
                        color: Colors.white,
                        fontWeight: FontWeight.w900, // Thicker weight for prominence
                        letterSpacing: 1.2, // Slight spacing for clarity
                      ),
                      textAlign: TextAlign.center,
                    );
                  },
                ),
                const SizedBox(height: 20),

                // Suspense message
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Text(
                    "Let's wait for the result.\nWere you able to save the world?",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      color: Colors.yellowAccent.shade100, // Softer yellow for a more elegant tone
                      fontStyle: FontStyle.italic,
                      height: 1.5, // Increased line height for better readability
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 40),

                // Call to action or back button

              ],
            ),
          ),
        ],
      ),
    );

  }
}
