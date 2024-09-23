import 'package:flutter/material.dart';
import 'package:maze_runner/features/constants/screens/riddle_complete_screen.dart';
import 'package:video_player/video_player.dart';

class VideoSplashScreen extends StatefulWidget {
  const VideoSplashScreen({super.key});

  @override
  _VideoSplashScreenState createState() => _VideoSplashScreenState();
}

class _VideoSplashScreenState extends State<VideoSplashScreen> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    // Video controller set up
    _controller = VideoPlayerController.asset('assets/clips/end_splash_1.mp4')
      ..initialize().then((_) {
        setState(() {});
        _controller.play();
        _controller.setPlaybackSpeed(0.8);
        _controller.setVolume(0);
      });

    // Navigate to next page after video ends
    _controller.addListener(() {
      if (_controller.value.position == _controller.value.duration) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const RiddleCompleteScreen()),
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
