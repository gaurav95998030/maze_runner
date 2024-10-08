import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:maze_runner/features/auth/controller/auth_controller.dart';
import 'package:maze_runner/features/auth/loaders/login_loader_provider.dart';
import 'package:maze_runner/features/constants/screens/thanos_comming_page.dart';
import 'package:video_player/video_player.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  late VideoPlayerController _controller;
  final _formKey = GlobalKey<FormState>();

  String teamname = '';
  String mobile = '';

  @override
  void initState() {
    print("login state workinh");
    super.initState();
    _controller = VideoPlayerController.asset('assets/clips/login.mp4')
      ..initialize().then((_) {
        setState(() {}); // Ensure UI rebuild after initialization
        _controller.setLooping(true);
        _controller.setPlaybackSpeed(0.5);
        _controller.setVolume(0);
        _controller.play();
      });
  }

  @override
  void didUpdateWidget(covariant LoginScreen oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    _controller = VideoPlayerController.asset('assets/clips/login.mp4')
      ..initialize().then((_) {
        setState(() {}); // Ensure UI rebuild after initialization
        _controller.setLooping(true);
        _controller.setPlaybackSpeed(0.5);
        _controller.setVolume(0);
        _controller.play();
      });
  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void handleGetStartedClick() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      String res = await ref.read(authControllerProvider).loginUser(teamname: teamname, mobile: mobile);



      if (res == "success") {

        if(mounted){
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (ctx) => const ThanosComingPage()),
          );
        }

      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Ensure video is only shown after initialization
          _controller.value.isInitialized
              ? SizedBox.expand(
            child: FittedBox(
              fit: BoxFit.cover,
              child: SizedBox(
                width: _controller.value.size.width,
                height: _controller.value.size.height,
                child: VideoPlayer(_controller),
              ),
            ),
          )
              : const Center(child: CircularProgressIndicator()),

          // Login form over the video
          Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 40),
                      // Marvel theme title
                      Text(
                        'Welcome, Hero!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.redAccent,
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Marvel',
                          letterSpacing: 1.5,
                        ),
                      ),
                      const SizedBox(height: 30),
                      // Team ID input
                      Theme(
                        data: Theme.of(context).copyWith(
                          inputDecorationTheme: const InputDecorationTheme(
                            errorStyle: TextStyle(color: Colors.white),
                          ),
                        ),
                        child: TextFormField(
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return "Please Enter a Valid Team ID";
                            }
                            return null;
                          },
                          onSaved: (value) {
                            teamname = value!;
                          },
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.black.withOpacity(0.8),
                            labelText: 'Team ID',
                            labelStyle: const TextStyle(
                              color: Colors.redAccent,
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                            hintText: 'Enter your Team ID',
                            hintStyle: TextStyle(
                              color: Colors.grey[400],
                              fontSize: 14,
                            ),
                            prefixIcon: const Icon(
                              Icons.person,
                              color: Colors.redAccent,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Password input
                      Theme(
                        data: Theme.of(context).copyWith(
                          inputDecorationTheme: const InputDecorationTheme(
                            errorStyle: TextStyle(color: Colors.white),
                          ),
                        ),
                        child: TextFormField(
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return "Please Enter a Valid Password";
                            }
                            return null;
                          },
                          onSaved: (value) {
                            mobile = value!;
                          },
                          obscureText: true,
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.black.withOpacity(0.8),
                            labelText: 'Password',
                            labelStyle: const TextStyle(
                              color: Colors.redAccent,
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                            hintText: 'Enter your Password',
                            hintStyle: TextStyle(
                              color: Colors.grey[400],
                              fontSize: 14,
                            ),
                            prefixIcon: const Icon(
                              Icons.lock,
                              color: Colors.redAccent,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 40),
                      // Login button
                      Consumer(
                        builder: (context, ref, child) {
                          bool isLoading = ref.watch(loginLoaderProvider);
                          return ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              disabledBackgroundColor: Colors.red[500],
                              backgroundColor: Colors.redAccent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 18),
                              elevation: 6,
                              shadowColor: Colors.redAccent.withOpacity(0.5),
                            ),
                            onPressed: isLoading ? null : handleGetStartedClick,
                            child: Text(
                              isLoading ? "Please Wait" : 'Get Started',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                letterSpacing: 1.2,
                              ),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 30),
                      // Footer text
                      const Text(
                        'Powered by UCC DA',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          letterSpacing: 1.0,
                        ),
                      ),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
