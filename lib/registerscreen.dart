import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:practice/loginscreen.dart';
import 'package:practice/main.dart';
import 'package:intl/intl.dart';
import 'package:email_validator/email_validator.dart';
import 'package:practice/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';



class RegisterScreen extends StatefulWidget {
  @override
  State<RegisterScreen> createState() => RegisterScreenState();
}

class RegisterScreenState extends State<RegisterScreen> {
  final formKey = GlobalKey<FormState>();

  // void initState(){/
    bool hidder = true;


    // DateTime? datePicked;
  // }

  var n1 = ['Jatin'];
  var n2 =["Mittal"];

  var name = TextEditingController();

  var email = TextEditingController();


  var password = TextEditingController();

  var dataPicked = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: height>600 ? AppBar() : null,

            body: SingleChildScrollView(
              child: Container(
                width: 380.w,
                height: 600.h,
                margin: EdgeInsets.only(top: 40,left: 15.w,right: 15.w),
                decoration: BoxDecoration(
                  color: Colors.grey.shade400,
                  borderRadius: BorderRadius.circular(20),

                ),
                child:Form(
                  key: formKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 30.h,bottom: 25.h),
                        child: Text('Register/Login',style: TextStyle(fontSize: 20.sp,color: Colors.black,fontWeight: FontWeight.bold),),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 16.h,left: 10.w,right: 10.w),
                        child: TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (firstName) => firstName != null && !firstName.isAlphabetOnly
                          ? "Enter correct name" : null,
                          controller: name,
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(26.r),
                            ),
                            prefixIcon: Icon(Icons.account_circle,),
                            labelText: 'Name',
                          ),
                          style: TextStyle(fontSize: 15.sp),
                          textInputAction: TextInputAction.next,
                          autofillHints: [AutofillHints.name],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 16.h,left: 10.w,right: 10.w),
                        child: TextFormField(
                          controller: email,
                          keyboardType: TextInputType.name,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (emailText) => emailText != null && !EmailValidator.validate(emailText)
                            ? "Enter valid email" : null,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(26),
                            ),
                            prefixIcon: Icon(Icons.email_outlined),
                            labelText: 'Email',
                          ),
                          style: TextStyle(fontSize: 15.sp),
                          textInputAction: TextInputAction.next,
                          autofillHints: [AutofillHints.email],


                        ),
                      ),

                      Padding(
                        padding:EdgeInsets.only(bottom: 16.h,left: 10.w,right: 10.w),
                        child: TextFormField(
                          controller: dataPicked,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(26.r),
                            ),
                            labelText: "Date of Birth",
                            prefixIcon: Icon(Icons.access_time_filled_outlined),
                            suffixIcon: IconButton(
                              onPressed: ()async {
                                  DateTime? dateInput=await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(1940),
                                  lastDate: DateTime(2025),
                                );
                                  if(dateInput != null){
                                    String dateFormate = DateFormat('dd-MM-yyyy').format(dateInput);
                                    setState(() {
                                      dataPicked.text=dateFormate;
                                    });
                                  }
                              },
                              icon:Icon(Icons.calendar_month_outlined),
                            ),
                          ),
                          style: TextStyle(fontSize: 15.sp),
                          textInputAction: TextInputAction.next,
                          autofillHints: [AutofillHints.birthday],


                          // readOnly: true,

                        ),
                      ),
                      Padding(
                        padding:EdgeInsets.only(bottom: 16.h,left: 10.w,right: 10.w),
                        child: TextFormField(
                          obscureText: hidder,
                          controller: password,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (passText) => passText != null && passText.length<9
                            ? "Mininmum 8 digit password"
                          : null,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(26.r),
                              ),
                              prefixIcon: Icon(Icons.password),
                              labelText: 'Password',

                              suffixIcon: IconButton(
                                icon: Icon(hidder ? Icons.visibility : Icons.visibility_off),
                                onPressed: (){
                                  setState(() {
                                    hidder =! hidder;
                                  });

                                },
                              )

                          ),
                          style: TextStyle(fontSize: 15.sp),
                          textInputAction: TextInputAction.next,


                        ),
                      ),
                      // SizedBox(height: 10.h,),
                      Padding(
                        padding: EdgeInsets.only(top:10.h),
                        child: ElevatedButton(
                            onPressed: (){
                              signUp();
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("Register",style: TextStyle(fontSize: 22),),
                            )
                        ),
                      ),
                      TextButton(onPressed: (){
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));
                      }, child: Text('Already a account?/Login',style: TextStyle(color: Colors.red,fontSize: 18),)),

                    ],
                  ),
                ),


              ),
            ),
    );
  }

  void signUp() async {
    final isValid = formKey.currentState!.validate();
    if(!isValid) return;
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Center(child: CircularProgressIndicator())
    );
    try{
      await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email.text.trim(), password: password.text.trim());
      var baseUser = await FirebaseAuth.instance.currentUser!;
      FirebaseFirestore.instance.collection('Users').doc(baseUser.uid)
          .set({'Name': name.text,'Email':email.text,'DOB': dataPicked.text})
          .then((value) => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MyHomePage(title: 'Care')))
      );

    } on FirebaseAuthException catch(e){
      print(e);
      navigatorKey.currentState!.popUntil((route) => route.isFirst);
      Utils.showSnackBar(e.message,2);


    }


  }
  
}

// Padding(
//   padding: const EdgeInsets.only(top:20.0,left: 8,right: 8,bottom: 8),
//   child: TextField(
//     controller: firstName,
//     keyboardType: TextInputType.name,
//     decoration: InputDecoration(
//       border: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(26),
//       ),
//       prefixIcon: Icon(Icons.account_circle),
//       hintText: 'First name',
//     ),
//   ),
// ),
// Padding(
//   padding: const EdgeInsets.all(8.0),
//   child: TextField(
//     controller: lasttName,
//     keyboardType: TextInputType.name,
//     decoration: InputDecoration(
//       border: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(26),
//       ),
//       prefixIcon: Icon(Icons.account_circle),
//       hintText: 'Last name',
//     ),
//   ),
// ),
// Padding(
//   padding: const EdgeInsets.all(8.0),
//   child: TextField(
//     controller: emailText,
//     keyboardType: TextInputType.emailAddress,
//     decoration: InputDecoration(
//       border: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(26),
//       ),
//       prefixIcon: Icon(Icons.email),
//       hintText: 'Enter email',
//
//     ),
//   ),
// ),
// Padding(
//   padding: const EdgeInsets.all(8.0),
//   child: TextField(
//     controller: phoneNumber,
//     keyboardType: TextInputType.phone,
//     decoration: InputDecoration(
//       border: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(26),
//       ),
//       prefixIcon: Icon(Icons.phone),
//       hintText: 'Enter number',
//
//     ),
//   ),
// ),

// ),
