import 'package:flutter/material.dart';
import 'package:practice/sidebar.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';


class UserData extends ChangeNotifier{

  String? _userData = "hello";
  String? get userData => _userData;
  
  Future getValue() async {
    final pref = await SharedPreferences.getInstance();
    _userData = pref.getString(keyName);
    notifyListeners();
  }

  
  
}