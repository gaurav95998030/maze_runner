





import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:maze_runner/features/auth/modal/user_modal.dart';

class UserNotifier extends StateNotifier<LoginResponse?>{

  final Ref ref;
   UserNotifier(this.ref):super(null);


   void loadTeam(){

   }


   void updateTeam(LoginResponse team){

     state = team;

   }

   void updateTeamScore(){

   }

}





final teamProvider =  StateNotifierProvider<UserNotifier,LoginResponse?>((ref)=>UserNotifier(ref));