import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:practice/main.dart';
import 'package:practice/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';


Map<String,dynamic>? user;
class FacebookLogin extends ChangeNotifier{

  // FacebookLogin? _user;
  AccessToken? accessToken;



  // FacebookLogin? get user => _user;

  Future facebookSignIn(context) async{
    final result = await FacebookAuth.instance.login();
    if(result.status == LoginStatus.success){
      accessToken=result.accessToken;
      print(accessToken);
      final _user = await FacebookAuth.instance.getUserData();
      user=_user;
      print(user);
    }
    try{
      final OAuthCredential credential = FacebookAuthProvider.credential(result.accessToken!.token);
      await FirebaseAuth.instance.signInWithCredential(credential);
      var baseUser = FirebaseAuth.instance.currentUser!;
      FirebaseFirestore.instance.collection('Users').doc(baseUser.uid).set({'Name':user!['name'], 'Email': user!['email'], 'DOB' : user!['user_birthday'], 'Gender' : user!['user_gender']});

    }on FirebaseAuthException catch(e){
      print(e);
    }
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MyHomePage(title: 'Care')));

  }

}
