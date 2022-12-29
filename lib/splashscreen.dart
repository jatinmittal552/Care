import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:practice/loginchoicescreen.dart';
import 'package:practice/loginscreen.dart';
import 'package:practice/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';


class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3),(){
      User? currentUser =  FirebaseAuth.instance.currentUser;
      if(currentUser==null){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> LoginChoice()));
      }
      else{
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> MyHomePage(title: 'Care')));

      }

    });

  }
  @override
  Widget build(BuildContext context) {
   return Scaffold(
     body: Container(
       color: Colors.red.shade500,
       child: Center(
           child: Container(
             width: 170,
             height: 170,
             child: CircleAvatar(
               radius: 50.sp,
               backgroundImage: AssetImage('assets/images/pickpocket.jpg'),

             ),
           ),
       ),
     ),

   );

  }


  // void nextscrren(context) {
  //   Timer(Duration(seconds: 3),()
  //   {
  //     StreamBuilder<User?>(
  //         stream: FirebaseAuth.instance.authStateChanges(),
  //         builder: (context, snapsot) {
  //           if (snapsot.hasData) {
  //             return navigateTo(MyHomePage(title: 'Care'));
  //           }
  //           else {
  //             return navigateTo(LoginChoice());
  //           }
  //         }
  //
  //     );
  //   });
    // var pref = await SharedPreferences.getInstance();
    // var result = pref.getBool(Result);
    //

  //   Timer(Duration(seconds: 3),(){
  //     if (result != null){
  //       if(result){
  //         Navigator.pushReplacement(this.context, MaterialPageRoute(builder: (context) => MyHomePage(title: 'Care',)));
  //       }
  //       else{
  //         Navigator.pushReplacement(this.context, MaterialPageRoute(builder: (context) => LoginChoice()));
  //       }
  //     }
  //     else{
  //       Navigator.pushReplacement(this.context, MaterialPageRoute(builder: (context) => LoginChoice()));
  //
  //     }
  //   });
  // }

  // navigateTo(page) {
  //   final navigatorTo = (page) => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => page));
  //   return navigatorTo;

  // }
}




