import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:maze_runner/features/auth/providers/login_state_provider.dart';
import 'package:maze_runner/features/auth/screens/login_screen.dart';
import 'package:maze_runner/features/constants/screens/endling_video_splash_screen.dart';
import 'package:maze_runner/features/constants/screens/thanos_comming_page.dart';
import 'package:maze_runner/features/riddles/providers/is_game_completed_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        themeMode: ThemeMode.light,
      debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFFED1D24), // Marvel Red
            brightness: Brightness.light, // Assuming a dark theme
          ),
          useMaterial3: true,
        ),
        home: const LoginScreen()
        //  Consumer(
        //   builder: (context,ref,child) {
        //
        //     AsyncValue<bool> isCompleted = ref.watch(isGameCompleteProvider);
        //
        //     return isCompleted.when(
        //         data: (data){
        //           if(data==true){
        //             return const VideoSplashScreen();
        //           }
        //
        //           return const LoginScreen();
        //         },
        //         error: (err,st)=>Center(child: Text("Some error occurred Please close and then open the app"),),
        //         loading: ()=>Center(child: CircularProgressIndicator(),)
        //     );
        //     return const LoginScreen();
        //   }
        // )

      ),
    );
  }
}

