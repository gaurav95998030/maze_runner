

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ShowSnackBarMSg{


  static showMsg(String msg){
  return  Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.blue,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }
}