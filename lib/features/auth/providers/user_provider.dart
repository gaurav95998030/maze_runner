





import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:maze_runner/features/auth/modal/user_modal.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserNotifier extends StateNotifier<LoginResponse?>{

  final Ref ref;
   UserNotifier(this.ref):super(null);





   Future<bool> updateTeam(LoginResponse team) async{
     final SharedPreferences prefs = await SharedPreferences.getInstance();

    bool res =   await prefs.setString('token', team.token);

     state = team;

     return res;

   }

   void updateTeamScore(int score){

     Team team = Team(id: state!.team.id, teamname: state!.team.teamname, teamlead: state!.team.teamlead, email: state!.team.email, mobile: state!.team.mobile, teamscore: state!.team.teamscore+score, lastSolvedAt: state!.team.lastSolvedAt);

     LoginResponse loginResponse = LoginResponse(message: state!.message, token: state!.token, team: team);

     state = loginResponse;


   }



}





final teamProvider =  StateNotifierProvider<UserNotifier,LoginResponse?>((ref)=>UserNotifier(ref));