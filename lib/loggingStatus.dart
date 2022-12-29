import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:practice/loginchoicescreen.dart';
import 'package:practice/main.dart';


class LoginStatus{
  loginStatus() {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting){
            return Center(child: CircularProgressIndicator());
          }
          else if(snapshot.hasData){
            return MyHomePage(title: "Care");

          }
          else if(snapshot.hasError){
            return Center(child: Text("Something went wrong"));
          }
          else{
            return LoginChoice();
          }
        });
  }

}