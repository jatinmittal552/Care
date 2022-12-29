import 'package:flutter/material.dart';
import 'package:practice/main.dart';


class Utils{
  static showSnackBar(String? text,var s){
    if (text==null) return;
    final snackBar= SnackBar(content: Text(text),backgroundColor: Colors.red,duration: Duration(seconds: s),);
    messengerKey.currentState!
    ..removeCurrentSnackBar()
    ..showSnackBar(snackBar);


  }
}