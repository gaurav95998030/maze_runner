
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:maze_runner/features/riddles/providers/riddles_provider.dart';
import 'package:maze_runner/features/riddles/widgets/show_riddle.dart';

import '../modals/riddle_modal.dart';

class RiddleScreen extends StatefulWidget {
  const RiddleScreen({super.key});

  @override
  State<RiddleScreen> createState() => _RiddleScreenState();
}








class _RiddleScreenState extends State<RiddleScreen> {


  int currentRiddleIndex = 0;

  void handleNextClick(){
    if(currentRiddleIndex==5)
      return;

    setState(() {
      currentRiddleIndex=currentRiddleIndex+1;
    });
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
