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

  String teamname= '';
  String mobile = '';

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('assets/clips/login.mp4') // Path to your MP4 file
      ..initialize().then((_) {
        _controller.setLooping(true); 
        _controller.setPlaybackSpeed(0.5);
        _controller.setVolume(0);// Loop the video infinitely
        _controller.play(); // Start playing the video
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller.dispose(); // Dispose of the controller when screen is closed
    super.dispose();
  }


  void handleGetStartedClick() async{
    if(_formKey.currentState!.validate()){
      _formKey.currentState!.save();

     String res = await ref.read(authControllerProvider).loginUser(teamname: teamname, mobile: mobile);

     if(!mounted) return;

     if(res=="success"){
       Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx)=>const ThanosComingPage()));

     }

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background video
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

          // Login form on top of the video
          Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 30),
                      // Marvel Theme Title
                      Text(
                        'Welcome, Hero!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.redAccent,
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Marvel',
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Team ID input
                      TextFormField(
                        validator: (value){
                          if(value==null||value.trim().isEmpty){
                            return "Please Enter Valid Teamname";
                          }
                          return null;
                        },
                        onSaved: (value){
                          teamname = value!;
                        },
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.grey[900]?.withOpacity(0.8),
                          labelText: 'Team ID',
                          labelStyle: TextStyle(color: Colors.redAccent),
                          hintText: 'Enter your Team ID',
                          hintStyle: TextStyle(color: Colors.grey),
                          prefixIcon: Icon(Icons.person, color: Colors.redAccent),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Password input
                      TextFormField(
                        validator: (value){
                          if(value==null ||value.trim().isEmpty){
                            return "Please Enter Valid Teamname";
                          }
                          return null;
                        },
                        onSaved: (value){
                          mobile = value!;
                        },
                        obscureText: true,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.grey[900]?.withOpacity(0.8),
                          labelText: 'Password',
                          labelStyle: TextStyle(color: Colors.redAccent),
                          hintText: 'Enter your Password',
                          hintStyle: TextStyle(color: Colors.grey),
                          prefixIcon: Icon(Icons.lock, color: Colors.redAccent),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      // Login button
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.redAccent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                        onPressed: () {


                           handleGetStartedClick();


                        },
                        child: Consumer(
                          builder: (context,ref,child) {
                            bool isLoading = ref.watch(loginLoaderProvider);
                            return  Text(
                              isLoading?"Please Wait":'Get Started',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            );
                          }
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Footer text
                      const Text(
                        'Powered by UCC DA ',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 30),
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
