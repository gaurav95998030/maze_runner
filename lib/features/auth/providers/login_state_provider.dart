



import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';


Future<bool> loadTeam() async{
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  final String? token = prefs.getString('token');

  if(token!=null){
    return true;
  }
  return false;
}

final loginStateProvider = FutureProvider<bool>((ref)=>loadTeam());