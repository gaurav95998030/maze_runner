




import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:maze_runner/features/auth/modal/user_modal.dart';
import 'package:maze_runner/features/auth/providers/user_provider.dart';
import 'package:maze_runner/features/riddles/modals/riddle_modal.dart';
import 'package:maze_runner/features/riddles/services/riddle_service.dart';

class RiddleNotifer extends StateNotifier<List<RiddleResponse>>{
Ref ref;
  RiddleNotifer(this.ref):super([]);


  Future<bool> loadRiddles() async{

    LoginResponse team = ref.read(teamProvider)!;



      String token = team.token;
      state = await RiddleService.getRiddles(token);

      if(state.isEmpty){
        return false;
      }


      return true;


  }


  void checkRiddle(RiddleResponse riddle,String userAnswer) async{
    LoginResponse? loginResponse = ref.read(teamProvider);

    String token = loginResponse!.token;
     RiddleService.checkRiddle(riddle.riddle, token, userAnswer, riddle.teamId);
  }


  // int getCurrentScore(int score, String riddleId){
  //
  //   RiddleResponse riddleResponse = state.firstWhere((riddle)=>riddle.riddleId==riddleId);
  //
  //
  //
  //
  // }
}




final riddleProvider = StateNotifierProvider<RiddleNotifer,List<RiddleResponse>>((ref)=>RiddleNotifer(ref));