import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:practice/main.dart';
import 'package:practice/registerscreen.dart';
import 'package:practice/splashscreen.dart';
import 'package:practice/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:practice/forgetPassword.dart';

class LoginScreen extends StatefulWidget {  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();

  // var r=420.h;
  bool hidder = true;
  // var arrEmail = ['jatinmittal552@gmail.com','jatinmittal969@gmail.com'];
  // var arrpassword= ['123456','1234567'];
  var emailText = TextEditingController();
  var passText = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Container(
          height: 530.h,
          width: 330.w,
          margin: EdgeInsets.only(top: 50.h,left: 10.w,right: 10.w),
          decoration: BoxDecoration(
              color: Colors.grey.shade400,
            borderRadius: BorderRadius.circular(16)
          ),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                Padding(
                  padding:EdgeInsets.only(top:60.h,left: 10.w,right: 10.w),
                  child: InkWell(onTap:(){},child: Text(' Login/Register ',style: TextStyle(fontSize: 21.sp,color: Colors.black,fontWeight: FontWeight.bold, ),textScaleFactor: 1,)),

                ),
                Padding(
                  padding: EdgeInsets.only(top: 23.h,left: 20.w,right: 20.w),
                  child: TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (emailText) => emailText != null && !EmailValidator.validate(emailText)
                    ? "Enter valid Email" : null,
                    controller: emailText,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      labelText: 'Email',
                      prefixIcon: Icon(Icons.mail)

                      // hintText: 'Enter Mail',
                      // hintStyle: TextStyle(fontSize: 20.sp)
                    ),
                    textInputAction: TextInputAction.next,
                    style: TextStyle(fontSize: 17.sp),
                    autofillHints: [AutofillHints.email],

                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 13.h,left: 20.w,right: 20.w,bottom: 12.h),
                  child: TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (passText) => passText!=null && passText.length<8
                    ? "Enter min 8 character"
                    :null,
                    controller: passText,
                    obscureText: hidder,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),


                      ),
                      labelText: 'Password',
                      prefixIcon: Icon(Icons.password),
                      suffixIcon: IconButton(
                        icon: Icon(hidder ? Icons.remove_red_eye : Icons.visibility_off),
                        onPressed:(){
                          setState(() {
                            hidder = !hidder;
                          });

                        } ,
                      )

                    ),
                    style: TextStyle(fontSize: 17.sp),

                  ),
                ),
                GestureDetector(
                  child: Padding(
                    padding: EdgeInsets.only(left: 20.w,right: 20.w,bottom: 14.h),
                    child: Text("Forget Password ?",
                      style: TextStyle(color: Colors.red,fontSize: 15),),
                  ),
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ForgetPassword()));
                  },
                ),
                ElevatedButton(
                  child: Text("Login",style: TextStyle(fontSize: 25),),
                  onPressed: () async {
                    SignIn();


                    // String E1= emailText.text.toString();
                    // String P1=passText.text;
                    // var l=arrEmail.length;
                    // print(l);
                    // for(int i=0;i<l;i++){
                    //   if(arrEmail[i]==E1){
                    //     if(arrpassword[i]==P1){
                    //       var sharedpref= await SharedPreferences.getInstance();
                    //       sharedpref.setBool(SplashScreenState.Result, true);
                    //       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MyHomePage(title: 'Care')),);

                    //
                    //     }
                    //     else{
                    //       child: Text('Incorrect Password',style: TextStyle(color: Colors.red,fontSize: 5,fontWeight: FontWeight.bold),);
                    //     }
                    //   }
                    // }


                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      padding: EdgeInsets.all(10),
                      textStyle: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                      )
                  ),
                ),

                Padding(
                  padding: EdgeInsets.all(7.h),
                  child: TextButton(
                    child: Text('New to here?/Register',style: TextStyle(color: Colors.red,fontSize: 17),
                    ),
                    onPressed: (){
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => RegisterScreen()));
                    },
                  ),
                ),


              ],

            ),
          ),

        ),
      ),
    );
  }

  void SignIn() async {
    final isValid = formKey.currentState!.validate();
    if(!isValid) return;
    showDialog(
        context: context,
        barrierDismissible: false,
        builder:(context) => Center(child: CircularProgressIndicator())
    );
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailText.text.trim(), password: passText.text.trim());
      Navigator.push(context, MaterialPageRoute(builder: (context) => MyHomePage(title: "Care")));

    }on FirebaseAuthException catch (e){
      print(e);
      navigatorKey.currentState!.popUntil((route)=>route.isFirst);
      Utils.showSnackBar(e.message,2);

    }
  }
}
