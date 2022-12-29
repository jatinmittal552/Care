import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:practice/main.dart';
import 'package:practice/utils.dart';

class GoogleLogin extends ChangeNotifier {
  final googleSignIn = GoogleSignIn();
  GoogleSignInAccount? _user;

  GoogleSignInAccount get user => _user!;

  Future gogleLogin(context) async {
    showDialog(context: context,
        builder: (context) => Center(child: CircularProgressIndicator()));
    final googleUser = await googleSignIn.signIn();
    if (googleUser == null) {return navigatorKey.currentState!.popUntil((route) => route.isFirst);}
    _user = googleUser;
    print(_user);

    final googleAuth = await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    try {
      await FirebaseAuth.instance.signInWithCredential(credential);
      var baseUser = FirebaseAuth.instance.currentUser!;
      FirebaseFirestore.instance.collection('Users').doc(baseUser.uid).set({'Name' : _user?.displayName, 'Email': _user?.email}).then((value) =>
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => MyHomePage(title: "Care"))));
    } on FirebaseAuthException catch (e) {
      Utils.showSnackBar(e.message, 3);
      navigatorKey.currentState!.popUntil((route) => route.isFirst);
    }
  }
}
