




import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:maze_runner/features/auth/modal/user_modal.dart';
import 'package:maze_runner/features/auth/providers/user_provider.dart';
import 'package:maze_runner/features/riddles/modals/riddle_modal.dart';
import 'package:maze_runner/features/riddles/providers/get_riddles_loader_provider.dart';
import 'package:maze_runner/features/riddles/providers/next_riddle_loader_provider.dart';
import 'package:maze_runner/features/riddles/services/riddle_service.dart';

class RiddleNotifer extends StateNotifier<List<RiddleResponse>>{
Ref ref;
  RiddleNotifer(this.ref):super([]);


  Future<bool> loadRiddles() async{

    LoginResponse team = ref.read(teamProvider)!;

    ref.read(loadRiddleLoaderProvider.notifier).update((cb)=>true);

      String token = team.token;
      state = await RiddleService.getRiddles(token);

      if(state.isEmpty){

        ref.read(loadRiddleLoaderProvider.notifier).update((cb)=>false);
        return false;
      }

    ref.read(loadRiddleLoaderProvider.notifier).update((cb)=>false);
      return true;


  }


  Future<String> checkRiddle(RiddleResponse riddle,String userAnswer) async{


    ref.read(nextRiddleLoaderProvider.notifier).update((cb)=>true);
    LoginResponse? loginResponse = ref.read(teamProvider);

    String token = loginResponse!.token;
    String res =   await RiddleService.checkRiddle(riddle.riddle, token, userAnswer, riddle.teamId);

    ref.read(nextRiddleLoaderProvider.notifier).update((cb)=>false);
    return res;
  }


  void getCurrentScore(int score, String riddleId){

    RiddleResponse riddleResponse = state.firstWhere((riddle)=>riddle.riddleId==riddleId);

    ref.read(teamProvider.notifier).updateTeamScore(score);








  }
}




final riddleProvider = StateNotifierProvider<RiddleNotifer,List<RiddleResponse>>((ref)=>RiddleNotifer(ref));