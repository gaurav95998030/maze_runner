import 'package:flutter/material.dart';
import 'package:maze_runner/features/auth/screens/login_screen.dart';
import 'package:video_player/video_player.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('assets/clips/digi_week_intro.mp4')
      ..initialize().then((_) {
        setState(() {});
        _controller.play();
        _controller.setPlaybackSpeed(0.8);
        _controller.setVolume(0);
      });
    _controller.addListener(() {
      if (_controller.value.position == _controller.value.duration) {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
      }
    });
  }

  @override
  void didUpdateWidget(covariant IntroScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    _controller = VideoPlayerController.asset('assets/clips/digi_week_intro.mp4')
      ..initialize().then((_) {
        setState(() {});
        _controller.play();
        _controller.setPlaybackSpeed(0.8);
        _controller.setVolume(0);
      });


    _controller.addListener(() {
      if (_controller.value.position == _controller.value.duration) {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
      }
    });

  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _controller.value.isInitialized
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
    );
  }
}
