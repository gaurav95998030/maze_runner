import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:maze_runner/features/auth/modal/user_modal.dart';
import 'package:maze_runner/features/auth/providers/user_provider.dart';
import 'package:maze_runner/features/riddles/providers/get_riddles_loader_provider.dart';
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
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Consumer(
                    builder: (context, ref, child) {
                      LoginResponse? state = ref.watch(teamProvider);

                      return Text(
                        state != null
                            ? "Welcome, Team ${state.team.teamname}"
                            : "Welcome, Team",
                        style: TextStyle(
                          color: Colors.yellow.shade600,
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1.2,
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 20),

                  // Hero message
                  const Text(
                    "Thanos is Coming for You...",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.redAccent,
                      fontSize: 40,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.8,
                      shadows: [
                        Shadow(
                          blurRadius: 12.0,
                          color: Colors.black54,
                          offset: Offset(3, 3),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),

                  // Challenge description
                  const Text(
                    "Be a Mystery Solver and Save the World!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.4,
                      shadows: [
                        Shadow(
                          blurRadius: 8.0,
                          color: Colors.black45,
                          offset: Offset(2, 2),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),

                  // Brief game description
                  Text(
                    "Eight Infinity Stones are hidden, each protected by a riddle. Only a true mystery solver can defeat Thanos and protect the universe.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.grey[300],
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      height: 1.6,
                    ),
                  ),
                  const SizedBox(height: 60),

                  // Start button
                  Consumer(
                    builder: (context, ref, child) {
                      bool isLoading = ref.watch(loadRiddleLoaderProvider);

                      return ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          disabledBackgroundColor: Colors.red.withOpacity(0.6),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(32),
                          ),
                          padding: const EdgeInsets.symmetric(
                            vertical: 18,
                            horizontal: 36,
                          ),
                        ),
                        onPressed: isLoading ? null : () async {
                          bool res = await ref.read(riddleProvider.notifier).loadRiddles();

                          if (res) {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(builder: (ctx) => const RiddleScreen()),
                            );
                          }
                        },
                        child: Text(
                          isLoading ? "Loading Riddles..." : 'Start Your Quest',
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      );
                    },
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
