import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:practice/facebooklogin.dart';
import 'package:practice/googlelogin.dart';
import 'package:practice/loginscreen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:practice/main.dart';
import 'package:practice/sidebar.dart';
import 'package:practice/utils.dart';
import 'package:provider/provider.dart';

class LoginChoice extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // wid = MediaQuery.of(context).size.width;
    final height = MediaQuery
        .of(context)
        .size
        .height;
    return Scaffold(
      appBar: height > 600 ? AppBar() : null,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 180.h,),
            Expanded(
              child: GestureDetector(

                onTap: () {
                  final provider = context.read<GoogleLogin>();
                  provider.gogleLogin(context);
                  // googleLogin();
                },
                child: Container(
                  width: 333.w,
                  // height: 80.h,
                  margin: EdgeInsets.only(
                      bottom: 29.h, left: 15.w, right: 15.w),
                  decoration: BoxDecoration(
                    color: Colors.blueAccent.shade700,
                    borderRadius: BorderRadius.circular(29),
                    boxShadow: [BoxShadow(
                      blurRadius: 7,
                      spreadRadius: 5,
                      color: Colors.white,
                    )
                    ],
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 44.r,
                        height: 44.r,
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          backgroundImage: AssetImage(
                              'assets/images/google.png'),

                        ),
                      ),
                      SizedBox(width: 6.w,),
                      Text('Continue with Google', style: TextStyle(
                          fontSize: 17.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),

                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: InkWell(
                onTap: () {
                  final provider = context.read<FacebookLogin>();
                  provider.facebookSignIn(context);

                },
                child: Container(
                  width: 333.w,
                  height: 80.h,
                  margin: EdgeInsets.only(bottom: 29.h, left: 15.w, right: 15.w),
                  decoration: BoxDecoration(
                    color: Colors.indigo,
                    borderRadius: BorderRadius.circular(29),
                    boxShadow: [BoxShadow(
                      blurRadius: 7,
                      spreadRadius: 5,
                      color: Colors.white,
                    )
                    ],
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 44.r,
                        height: 44.r,
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          backgroundImage: AssetImage('assets/images/facebook2.png'),

                        ),
                      ),
                      SizedBox(width: 6.w,),
                      Text('Continue with Facebook', style: TextStyle(fontSize: 17.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),

                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: InkWell(
                onTap: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => LoginScreen()));
                },
                child: Container(
                  width: 333.w,
                  height: 20.h,
                  margin: EdgeInsets.only(left: 15.w, right: 15.w),
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(29),
                    boxShadow: [BoxShadow(
                      blurRadius: 7,
                      spreadRadius: 5,
                      color: Colors.white,
                    )
                    ],
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // SizedBox(width : 1.w),
                      Icon(
                        Icons.login_outlined, size: 43.r,
                      ),
                      SizedBox(width: 8.w,),
                      Text('Login manually', style: TextStyle(
                          fontWeight: FontWeight.w400, fontSize: 18.sp),)

                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 200.h,),
          ],

        ),
      ),
    );
  }
}
  // helper(page, image, text, context, color) {
  //   return Expanded(
  //     child: InkWell(
  //       onTap: () {
  //         Navigator.pushReplacement(
  //             context, MaterialPageRoute(builder: (context) => page));
  //       },
  //       child: Container(
  //         width: 333.w,
  //         height: 80.h,
  //         margin: EdgeInsets.only(bottom: 29.h, left: 15.w, right: 15.w),
  //         decoration: BoxDecoration(
  //           color: color,
  //           borderRadius: BorderRadius.circular(29),
  //           boxShadow: [BoxShadow(
  //             blurRadius: 7,
  //             spreadRadius: 5,
  //             color: Colors.white,
  //           )
  //           ],
  //         ),
  //         child: Row(
  //           crossAxisAlignment: CrossAxisAlignment.center,
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           children: [
  //             Container(
  //               width: 44.r,
  //               height: 44.r,
  //               child: CircleAvatar(
  //                 backgroundColor: Colors.white,
  //                 backgroundImage: AssetImage(image),
  //
  //               ),
  //             ),
  //             SizedBox(width: 6.w,),
  //             Text(text, style: TextStyle(fontSize: 17.sp,
  //                 fontWeight: FontWeight.bold,
  //                 color: Colors.white),
  //
  //             ),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }

  //
  // void googleLogin() async {
  //   // showDialog(context: context,
  //   //     builder: (context) => Center(child: CircularProgressIndicator()));
  //   final googleSignIn = GoogleSignIn();
  //   final googleUser = await googleSignIn.signIn();
  //   if (googleUser == null) return null;
  //   GoogleSignInAccount? user = googleUser;
  //
  //   final googleAuth = await googleUser.authentication;
  //
  //   final credential = GoogleAuthProvider.credential(
  //     accessToken: googleAuth.accessToken,
  //     idToken: googleAuth.idToken,
  //
  //   );
  //
  //   print(user.displayName);

    // try {
    //   await FirebaseAuth.instance.signInWithCredential(credential);
      // Navigator.pushReplacement(context,
      //     MaterialPageRoute(builder: (context) => MyHomePage(title: 'Care')));
    // } on FirebaseAuthException catch (e) {
    //   Utils.showSnackBar(e.message, 3);
    //   navigatorKey.currentState!.popUntil((route) => route.isFirst);
    // }


    // }

// InkWell(
//     onTap: (){
//       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>GoogleLogin()));
//     },
//     child: Container(
//       width: 300.w,
//       height: 54.h,
//       margin: EdgeInsets.only(top: 180.h,bottom: 25.h),
//       decoration: BoxDecoration(
//         color: Colors.blueAccent.shade700,
//         borderRadius: BorderRadius.circular(29.r),
//         boxShadow: [BoxShadow(
//           blurRadius: 7,
//           spreadRadius: 5,
//           color: Colors.white,
//         )],
//       ),
//       child: Row(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(5.0),
//             child: Container(
//               width: 44.w,
//               height: 44.h,
//               child: CircleAvatar(
//                 backgroundColor: Colors.white,
//                 backgroundImage: AssetImage('assets/images/google.png'),
//
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8),
//             child: Text('Continue with Google',style: TextStyle(fontSize: 20.sp,fontWeight: FontWeight.bold,color: Colors.white),
//
//                 ),
//           ),
//         ],
//       ),
//     ),
//   ),
//   InkWell(
//     onTap: (){
//       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>FacebookLogin()));
//     },
//     child: Container(
//       width: 300.w,
//       height: 55.h,
//       margin: EdgeInsets.only(bottom: 20.h),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(29.r),
//         boxShadow: [BoxShadow(
//           blurRadius: 7,
//           spreadRadius: 5,
//           color: Colors.grey,
//         )],
//
//         color: Colors.indigo,
//       ),
//       child: Row(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(5.0),
//             child: Container(
//               width: 44.w,
//               height: 44.h,
//               child: CircleAvatar(
//                 backgroundColor: Colors.white,
//                 backgroundImage: AssetImage('assets/images/facebook2.png'),
//
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Text('Continue with Facebook',style: TextStyle(fontSize: 20.sp,fontWeight: FontWeight.bold,color: Colors.white),
//
//               ),
//           ),
//         ],
//       ),
//     ),
