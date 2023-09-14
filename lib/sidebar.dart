import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:practice/loginchoicescreen.dart';
import 'package:practice/loginscreen.dart';
import 'package:practice/navigation_provider.dart';
import 'package:practice/registerscreen.dart';
import 'package:practice/sidebar_item_constructor.dart';
import 'package:practice/sidebar_items.dart';
import 'package:provider/provider.dart';
import 'package:practice/main.dart';
import 'package:practice/profile.dart';
import 'package:practice/how_to_work.dart';
import 'package:practice/faq.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:practice/splashscreen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:practice/facebooklogin.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:practice/userData.dart';
import 'package:practice/facebooklogin.dart';


class SideBar extends StatefulWidget {

  @override
  State<SideBar> createState() => _SideBarState();
}

final keyName = "Name";



class _SideBarState extends State<SideBar> {
  var f1=RegisterScreenState().n1[0];

  var f2=RegisterScreenState().n2[0];

  final padding = EdgeInsets.symmetric(horizontal: 20.w);

  final googleSignIn = GoogleSignIn();

  // Map<String,dynamic>? userValue = FacebookLogin.user;



  // static late final userName;
  // var name;

  // getUserValue() async{
    // final baseUser = await FirebaseAuth.instance.currentUser!;
    // setState((){
      // FirebaseFirestore.instance.collection('Users').doc(baseUser.uid).get()
    // });
  // }

  // get data => null;
  @override
  void initState() {
    super.initState();
    setvalue();



  }
  setvalue() async{
    final baseUser = await FirebaseAuth.instance.currentUser!;
    final user = FirebaseFirestore.instance.collection("Users").doc(baseUser.uid);
    user.get().then((DocumentSnapshot doc) async {
      final data = doc.get('Name');
      final pref = await SharedPreferences.getInstance();
      pref.setString(keyName,data);

    },
        onError: (e) => print(e)
    );
  }



  @override
  Widget build(BuildContext context) {
    // print(userValue);

    final c= context.read<UserData>();
    c.getValue();
    final SafeArea = EdgeInsets.only(top: MediaQuery.of(context).viewPadding.top );
    final iscollapsed = context.watch<NavigationProvider>().iscollapsed;
    return Container(
      width: iscollapsed ? MediaQuery
            .of(context)
            .size
            .width * 0.20 : MediaQuery.of(context).size.width*0.6,
      child: Drawer(
          child: Container(
            color: Colors.black87,
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10.h).add(SafeArea),
                  width: double.infinity,
                  color: Colors.white10,
                  child: buildheader(iscollapsed),
                ),
                ClipRect(
                    child: buildcentre(items: Items, iscollapsed: iscollapsed)),
                Spacer(),
                buildbottomnavigator(context, iscollapsed),
                // SizedBox(height: 20.h,)

              ],

            ),
          ),
        ),
    );
  }

  Widget buildheader(bool iscollapsed) => iscollapsed
      ? Column(
        children: [
          SizedBox(height: 10.h,),
          Container(
              width: 55,
              height:55,

              child: Image.network(user!['picture']['data']['url'])),
          SizedBox(height: 25.h,),

        ],
      )
      : Column(
        children: [
          CircleAvatar(radius: 40.r,backgroundImage: AssetImage('assets/images/user.jpg'),),
          SizedBox(height: 20.h,),
          value(),
          SizedBox(
            height: 15.h,
          ),

        ],
      );
  Widget value(){
    final userName = context.watch<UserData>().userData;
    print(userName);

    return Text('$userName',style: TextStyle(fontSize: 20.sp,fontWeight: FontWeight.bold,color: Colors.grey),);


  }



  Widget buildcentre({required List<DrawItem> items, required bool iscollapsed}) =>
      ListView.separated(
        padding: iscollapsed ? EdgeInsets.only(top: 25.h) : EdgeInsets.symmetric(horizontal: 5.w,vertical: 14.h),
        shrinkWrap: true,
        primary: false,
        itemCount: items.length,
        separatorBuilder: (context,index) => SizedBox(height: 11.h,),
        itemBuilder: (context,index){
          final item=items[index];
          return Buildcentre(
            iscollapsed : iscollapsed,
              text: item.title,
              icon: item.icon,
            onClicked : () => navigatorlist(context,index),
          );
        }
    );

  void navigatorlist(BuildContext context, int index) async {
    final navigatorTo = (page) => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => page));
    switch(index){
      case 0:
        navigatorTo(MyHomePage(title: 'Care',));
        break;
      case 1:
        navigatorTo(Profile());
        break;
      case 2:
        navigatorTo(How_to_Work());
        break;
      case 3:
         navigatorTo(FAQ());
         break;
      case 4:
        setState(()  {
          FirebaseAuth.instance.signOut();
          googleSignIn.disconnect();
          FacebookAuth.instance.logOut();
          navigatorTo(LoginChoice());

          user =null;
          // FacebookLogin().accessToken = null;



        });

        // getValue();
        // var pref = SharedPreferences.getInstance();

    }
  }

  //
  Buildcentre({
    required bool iscollapsed,
    required String text,
    required IconData icon,
    VoidCallback? onClicked})
  => iscollapsed
      ? Column(
        children: [
          Material(color: Colors.transparent,child: Container(width:double.infinity,child: IconButton(onPressed: onClicked, icon: Icon(icon,size: 40.r,color: Colors.white,)))),
          SizedBox(height: 7.h,),
          Divider(height: 10.h,thickness:0.6.h,color: Colors.black,),
        ],
      )
      : Column(
        children: [
          Material(color:Colors.transparent,child: ListTile(leading: Icon(icon,color: Colors.white,size: 40.r,), title: Text(text,style: TextStyle(color:Colors.white,fontSize: 14.sp),),onTap: onClicked,)),
        ],
      );

}

// void getValue() async {
//   var pref = await SharedPreferences.getInstance();
//   var value = pref.setBool(SplashScreenState.Result,false);
// }

  buildbottomnavigator(BuildContext context,bool iscollapsed){
    final icon =iscollapsed ? Icons.arrow_forward_ios_sharp : Icons.arrow_back_ios_sharp;
    final alignment = iscollapsed ? Alignment.center : Alignment.centerRight;
    final margin = iscollapsed ? null : EdgeInsets.only(right: 15);
    final double size =50.h;
    final double width = iscollapsed ? double.infinity : size;

    return Container(
      alignment: alignment,
      margin: margin,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          child: Container(
            width: width,
            height: size,
            child: Icon(icon,color: Colors.white,),
          ),
          onTap: (){
            final provider = context.read<NavigationProvider>();
             provider.toggleIsCollapased();

          },
        ),
      ),
    );
  }


