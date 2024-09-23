





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

   void updateTeamScore(int score){

     Team team = Team(id: state!.team.id, teamname: state!.team.teamname, teamlead: state!.team.teamlead, email: state!.team.email, mobile: state!.team.mobile, teamscore: state!.team.teamscore+score, lastSolvedAt: state!.team.lastSolvedAt);

     LoginResponse loginResponse = LoginResponse(message: state!.message, token: state!.token, team: team);

     state = loginResponse;


   }



}





final teamProvider =  StateNotifierProvider<UserNotifier,LoginResponse?>((ref)=>UserNotifier(ref));