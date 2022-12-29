import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:practice/utils.dart';

class ForgetPassword extends StatefulWidget{
  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final formKey = GlobalKey<FormState>();
  var emailText = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white10,
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Text("Reset Password"),
      ),
      body: Form(
        key: formKey,
        child: Column(

          children: [
            SizedBox(
              height: 150.h,
            ),
            Padding(
              padding:  EdgeInsets.only(left: 18.w,right: 18.w,bottom: 10.h),
                child: Text("Receive password reset email link after enter email below\nCheck Spam also ",textAlign: TextAlign.center,style: TextStyle(fontSize: 22.sp,color: Colors.white,fontWeight: FontWeight.w200),),
              ),
            Padding(
              padding: const EdgeInsets.all(19.0),
              child: TextFormField(
                controller: emailText,
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(8),
                  labelText: 'Enter Email',
                  labelStyle: TextStyle(fontSize: 22.sp),
                  filled: true,
                  fillColor: Colors.white10,
                ),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (emailText) => emailText != null && !EmailValidator.validate(emailText)
                  ? "Enter valid Email"
                : null,
                style: TextStyle(fontSize: 17.sp,color: Colors.white),

              ),
            ),
            Padding(
              padding:EdgeInsets.only(left: 20.w,right: 20.w),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size.fromHeight(50)
                ),
                  onPressed: (){
                  resetPass();

                  },
                  child: Text("Reset Password",style: TextStyle(fontSize: 20.sp),)
              ),
            )
          ],
        ),
      ),

    );
  }

  void resetPass() async{
    if (!formKey.currentState!.validate())return;
    showDialog(
        context: context,
        builder: (context) => Center(child: CircularProgressIndicator())
    );
    try{
      await FirebaseAuth.instance.sendPasswordResetEmail(email:emailText.text.trim());
      Navigator.of(context).popUntil((route) => route.isFirst);
      Utils.showSnackBar("Password Reset Email Sent",4);
    }on FirebaseAuthException catch(e){
      Utils.showSnackBar(e.message,3);
      Navigator.of(context).pop();

    }

  }
}