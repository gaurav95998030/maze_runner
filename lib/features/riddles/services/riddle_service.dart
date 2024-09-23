
import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:maze_runner/features/auth/constants/constants.dart';
import 'package:maze_runner/features/auth/modal/user_modal.dart';
import 'package:maze_runner/features/auth/providers/user_provider.dart';

import 'package:maze_runner/features/riddles/modals/riddle_modal.dart';
import 'package:maze_runner/utils/show_snack_bar_msg.dart';

class RiddleService {

  static Future<List<RiddleResponse>> getRiddles(String token) async {
    try {
      List<RiddleResponse> riddles = [];
      final response = await http.get(
        Uri.parse("$baseUrl/api/getRiddles"),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        List<dynamic> responseBody = jsonDecode(response.body);

        for (var item in responseBody) {
          RiddleResponse riddleResponse = RiddleResponse.fromJson(item as Map<String, dynamic>);
          riddles.add(riddleResponse);
        }

        return riddles;
      } else {
        print('Failed to load riddles, status code: ${response.statusCode}');
      }
    } catch (err) {
      print('Error occurred: $err');
    }
    return []; // Return an empty list if there's an error
  }


  static Future<String> checkRiddle(Riddle riddle,String token,String userAnswer,int teamId) async{

    try{
      final response = await http.post(
        Uri.parse('$baseUrl/api/riddlesol'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          "riddleId": riddle.rid,
          "userAnswer": userAnswer,
          "teamId": teamId,
        }),
      );

         final responseData = jsonDecode(response.body) as Map<String, dynamic>;


      if(responseData['message']=="This riddle has already been solved by your team. No further attempts allowed."){
        ShowSnackBarMSg.showMsg("This question is already solved by team!!!. Moving to next Question");
        return "already solved";
      }

      if(responseData['message']=="Correct answer!"){
        return "correct answer ${responseData['score']}";

      }


      return responseData['message'];


    }catch(err){
      print(err);

      return 'Some error occurred';

    }
  }



}