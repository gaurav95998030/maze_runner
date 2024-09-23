
import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:maze_runner/features/auth/modal/user_modal.dart';
import 'package:maze_runner/features/auth/providers/user_provider.dart';
import 'package:maze_runner/utils/show_snack_bar_msg.dart';

import '../constants/constants.dart';

final authRepoProvider = Provider((ref)=>AuthRepo(ref:ref));

class AuthRepo{
  final Ref ref;
 const AuthRepo({required this.ref});
  Future<String> loginUser({required String teamname, required String mobile}) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/api/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({"teamlead_roll": teamname, "mobile": mobile}),
      );

      if (response.statusCode == 200) {
        // Decode the response body from JSON to a map
        final Map<String, dynamic> responseBody = jsonDecode(response.body);

        print(responseBody);
        // Update the team provider with the parsed LoginResponse
        ref.read(teamProvider.notifier).updateTeam(LoginResponse.fromJson(responseBody));

        return "success";
      }

      if(response.statusCode==400){
        ShowSnackBarMSg.showMsg("Please Enter Valid Credentials");
        return "failed";
      }

      else {
        return "failed with status: ${response.statusCode}";
      }
    } catch (err) {
      print(err);
      return "failed";
    }
  }


}