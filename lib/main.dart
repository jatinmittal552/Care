import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:practice/bluetooth.dart';
import 'package:practice/facebooklogin.dart';
import 'package:practice/googlelogin.dart';
import 'package:practice/navigation_provider.dart';
import 'package:practice/slidernavigator.dart';
import 'package:practice/splashscreen.dart';
import 'package:practice/ui_helper/textstyles.dart';
import 'package:practice/flipkart.dart';
import 'package:intl/intl.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'dart:async';
import 'dart:math';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:practice/sidebar.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:practice/utils.dart';
import 'package:practice/userData.dart';
import './bluetooth_serial.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:app_settings/app_settings.dart';

import 'bluetooth_serial.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => NavigationProvider()),
    ChangeNotifierProvider(create: (_) => SliderNavigator()),
    ChangeNotifierProvider(create: (_) => GoogleLogin()),
    ChangeNotifierProvider(create: (_) => FacebookLogin()),
    ChangeNotifierProvider(create: (_) => UserData())
  ],
      child: const MyApp()));
}
final navigatorKey=GlobalKey<NavigatorState>();
final messengerKey = GlobalKey<ScaffoldMessengerState>();


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // final text = MediaQuery.of(context).platformBrightness == Brightness.dark ? 'DarkTheme' : 'LightTheme';


      return ScreenUtilInit(
        builder: (context,child) =>  MaterialApp(
              scaffoldMessengerKey: messengerKey,
              navigatorKey: navigatorKey,
              title: 'Care',
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                primarySwatch: Colors.blue,
                scaffoldBackgroundColor: Colors.black,
              ),
              home: SplashScreen()
            ),
        designSize: const Size(350, 750),
      );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final flutterBlue = FlutterBluePlus.instance;
  late BluetoothDevice targetDevice;
  var isRecording;
  var list=[];
  int? _rssi;
  bool value = false;


  void performTask() {
    Timer.periodic(
      const Duration(seconds: 1),
          (Timer t) => {
        if(isRecording==true){
          for(int i=0;i<1000000;i++){
            print("hii"),
            if(list[i]==30){
              print("great"),
              // break;

            }

    }
    }

        // isRecording == true ? print("Working Task") : t.cancel(),
      },
    );
  }

  Future check(bool v) async{
    bool isBluetoothOn = await flutterBlue.isOn;
    if (isBluetoothOn) {
      print("Bluetooth is On");
      List<BluetoothDevice> devices = await flutterBlue.connectedDevices;
      print("helllo");
      for(BluetoothDevice device in devices){
        print("hiii");
        print("Connected device: ${device.name}");
        device.disconnect();
        device.connect();
        targetDevice = device;

        bool isConnected = device.state == BluetoothDeviceState.connected;

        print(isConnected);



        if(isConnected){
          print("plsssss");
        }
      }

    }else{
      print("Bluetooth is not enabled");
      await AppSettings.openBluetoothSettings();
    }


    trying(v);


    // print("rssi value : ${targetDevice!.readRssi()}");


  }

  void trying(bool v) async {
    Timer.periodic(Duration(milliseconds: 5), (timer) async {

      final rssi = await targetDevice.readRssi();
      setState(() {
        _rssi = rssi;
      });
      print("hello");

      if(rssi<-69 ){
        print("hel");
        FlutterRingtonePlayer.playRingtone();
        timer.cancel();
      }
      timerStop(timer,v);
      // print("Rssi value : ${_rssi}");
    });

  }
  void timerStop(Timer timer,bool v){
    if(!v){
      print("enter");

      timer.cancel();

    }
  }

  @override
  Widget build(BuildContext context)   => Scaffold(
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    drawer: SideBar(),
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text('Care'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: LiteRollingSwitch(
                value: false,
                colorOn: Colors.green,
                colorOff: Colors.grey,
                width: 80,
                onChanged:(bool position) {
                  position ?
                      check(position)

                              // Navigator.push(context, MaterialPageRoute(builder: (context) => bluetooth()))
                      :
                      // trying(position);
                          FlutterRingtonePlayer.stop();
                  setState(() {
                    _rssi=null;
                  });


                  // var i=10000;
                  // if (position == true){
                  //   Random random=new Random();
                  //     for(int i=0;i<1000000;i++){
                  //       var n=random.nextInt(50);
                  //       print("$n");
                  //       // print("Enter your number");
                  //       // var n=stdin.readLineSync();
                  //       // if(n!=null){
                  //       //   var num=int.parse(n);
                  //       // }
                  //       list.add(n);
                  //       if(list[i]==30){
                  //         print("great");
                  //         break;
                  // }
                  // }}
                },
                onTap: (){},
                onDoubleTap: (){},
                onSwipe: (){},
            ),
          ),

          // Switch(
          //     value: false,
          //     onChanged:(bool position) {
          //       print("$position");
          //     },
          // )
          // SwitchScreen()

        ],

      ),
      body:SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children:[
            Container(
              // width: 1800,
              height: 60.h,
              margin: EdgeInsets.only(top:20,left: 10,right: 10,bottom: 15),
              decoration:BoxDecoration(
                color: Colors.lightBlue,
                borderRadius: BorderRadius.circular(20),
              ),
              // child: Card(
              //     elevation: 12,
              //     color: Colors.blue,
              //     shadowColor: Colors.red,
                    child: Row(
                      children: [
                        Text("Ad:",style: TextStyle(color: Colors.red,fontSize: 11.sp),),
                        SizedBox(width: 70.w,),
                        Container(
                          width: 20.w,
                          height: 20.h,
                          child:CircleAvatar(
                            radius: 10.r,
                            backgroundImage: AssetImage('assets/images/octaimage.png'),
                          ),
                        ),
                        SizedBox(width: 25.w,),
                        Text("Octa ",style: TextStyle(color:Colors.white,fontSize: 20.sp,fontWeight: FontWeight.bold),),

                        Text("Fx",style: TextStyle(color:Colors.indigo,fontSize: 22.sp,fontWeight: FontWeight.bold),),
                        SizedBox(width: 25.w,),
                        Container(
                          width: 20.w,
                          height: 20.h,
                          child:CircleAvatar(
                            radius: 10.r,
                            backgroundImage: AssetImage('assets/images/octaimage.png'),
                          ),
                        ),
                      ],

                    // ),


              ),
            ),

            Container(
              width: double.infinity,
              height: 150.h,
              margin: EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.grey.shade500,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                            blurRadius: 10,
                            spreadRadius: 5,
                            color: Colors.green,

                  )
                ],
              ),
              child: Center(child: Text("$_rssi dB",style: TextStyle(fontSize: 20,color: Colors.red),)),
            ),


            Container(margin: EdgeInsets.only(top: 15,left: 15,right: 15,bottom: 12),child: Text("Special Sponsors",style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Colors.white),)),
            Container(
                height:104,
                width:double.infinity,
                // color: Colors.grey,
                margin: EdgeInsets.only(left: 14,right: 15),
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(19),

                ),
                child: GridView.count(
                  crossAxisCount: 3,
                  children: [
                    sponser('assets/images/flipkart.jpg',"Flipkart"),
                    sponser('assets/images/uber.png', "Uber"),
                    sponser('assets/images/ebay1.png',"Ebay"),
                    // Column(
                    //   children: [
                    //     SizedBox(width: 100),
                    //     Container(
                    //       height: 55,
                    //       width: 55,
                    //       margin: EdgeInsets.only(left:15,right:15,top:15,bottom:8),
                    //       child: InkWell(
                    //           onTap: (){
                    //             Navigator.push(context, MaterialPageRoute(builder: (context) => Flipkart()));
                    //           },
                    //           child: CircleAvatar(
                    //             radius: 30,
                    //             backgroundImage: AssetImage('assets/images/flipkart.jpg'),
                    //
                    //           )),
                    //       decoration: BoxDecoration(
                    //         shape: BoxShape.circle,
                    //         boxShadow: [
                    //           BoxShadow(
                    //             blurRadius: 6,
                    //             spreadRadius: 7,
                    //             color: Colors.grey,
                    //           )
                    //         ],
                    //         border: Border.all(
                    //           width: 1,
                    //           color: Colors.black
                    //         )
                    //       ),
                    //     ),
                    //     Text("Flipkart",style: text1(),)
                    //   ],
                    // ),
                    // Column(
                    //   children: [
                    //     SizedBox(width: 110),
                    //     Container(
                    //       height: 55,
                    //       width: 55,
                    //       margin: EdgeInsets.only(left:9,top:15,bottom:8,right: 15),
                    //       child:InkWell(
                    //           onTap: (){
                    //
                    //           },
                    //           child: CircleAvatar(
                    //             radius: 30,
                    //             backgroundImage: AssetImage('assets/images/uber.png'),
                    //
                    //           )
                    //       ),
                    //       decoration: BoxDecoration(
                    //         shape: BoxShape.circle,
                    //         boxShadow: [
                    //
                    //           BoxShadow(
                    //             blurRadius: 6,
                    //             spreadRadius: 7,
                    //             color: Colors.grey,
                    //           )
                    //         ],
                    //         border: Border.all(
                    //             width: 1,
                    //             color: Colors.black,
                    //         )
                    //
                    //       ),
                    //
                    //
                    //     ),
                    //     Text("Uber",style: text1())
                    //   ],
                    // ),
                    // Column(
                    //   children: [
                    //     SizedBox(width: 100),
                    //     Container(
                    //       height: 55,
                    //       width: 55,
                    //       margin: EdgeInsets.only(left:9,top:15,bottom:8,right: 15),
                    //       child:InkWell(
                    //           onTap: (){
                    //
                    //           },
                    //           child: CircleAvatar(
                    //             radius: 30,
                    //             backgroundImage: AssetImage('assets/images/ebay1.png'),
                    //
                    //           )
                    //       ),
                    //       decoration: BoxDecoration(
                    //         shape: BoxShape.circle,
                    //         boxShadow: [
                    //           BoxShadow(
                    //             blurRadius: 6,
                    //             spreadRadius: 7,
                    //             color: Colors.grey,
                    //
                    //           )
                    //         ],
                    //         border: Border.all(
                    //         width: 1,
                    //         color: Colors.black,
                    //         ),
                    //       ),
                    //     ),
                    //     Text("Ebay",style: text1())
                    //   ],
                    // ),

                  ],

                ),
            ),

            Container(margin: EdgeInsets.only(top: 25,left: 15,right: 15,bottom: 12),child: Text("Sponsors",style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Colors.white),)),
            Container(
              height:130,
              width:double.infinity,
              // color: Colors.grey,
              margin: EdgeInsets.only(left:14,right:15),
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(19),

              ),
              child: GridView.count(
                crossAxisCount: 3,
                padding: EdgeInsets.all(1.h),
                children: [
                  sponser("assets/images/flipkart.jpg","Flipkart"),
                  sponser('assets/images/uber.png',"Uber"),
                  sponser('assets/images/ebay1.png',"Ebay"),
                  sponser('assets/images/jio2.png',"Jio"),
                  sponser('assets/images/paytm1.png',"Paytm"),
                  sponser('assets/images/myntra.png',"Myntra"),
                  // Column(
                  //   children: [
                  //     Container(
                  //       height: 55,
                  //       width: 55,
                  //       margin: EdgeInsets.only(left:15,right:15,top:15,bottom:8),
                  //       child: InkWell(
                  //           onTap: (){
                  //             // Navigator.push(context, MaterialPageRoute(builder: (context) => Flipkart()));
                  //           },
                  //           child: CircleAvatar(
                  //             radius: 30,
                  //             backgroundImage: AssetImage('assets/images/flipkart.jpg'),
                  //
                  //           )),
                  //       decoration: BoxDecoration(
                  //           shape: BoxShape.circle,
                  //           boxShadow: [
                  //             BoxShadow(
                  //               blurRadius: 6,
                  //               spreadRadius: 7,
                  //               color: Colors.grey,
                  //             )
                  //           ],
                  //           border: Border.all(
                  //               width: 1,
                  //               color: Colors.black
                  //           )
                  //       ),
                  //     ),
                  //     Text("Flipkart",style: text1(),)
                  //   ],
                  // ),
                  // Column(
                  //   children: [
                  //     Container(
                  //       height: 55,
                  //       width: 55,
                  //       margin: EdgeInsets.only(left:9,top:15,bottom:8,right: 15),
                  //       child:InkWell(
                  //           onTap: (){
                  //
                  //           },
                  //           child: CircleAvatar(
                  //             radius: 30,
                  //             backgroundImage: AssetImage('assets/images/uber.png'),
                  //
                  //           )
                  //       ),
                  //       decoration: BoxDecoration(
                  //           shape: BoxShape.circle,
                  //           boxShadow: [
                  //
                  //             BoxShadow(
                  //               blurRadius: 6,
                  //               spreadRadius: 7,
                  //               color: Colors.grey,
                  //             )
                  //           ],
                  //           border: Border.all(
                  //             width: 1,
                  //             color: Colors.black,
                  //           )
                  //
                  //       ),
                  //
                  //
                  //     ),
                  //     Text("Uber",style: text1())
                  //   ],
                  // ),
                  // Column(
                  //   children: [
                  //     Container(
                  //       height: 55,
                  //       width: 55,
                  //       margin: EdgeInsets.only(left:9,top:15,bottom:8,right: 15),
                  //       child:InkWell(
                  //           onTap: (){
                  //
                  //           },
                  //           child: CircleAvatar(
                  //             radius: 30,
                  //             backgroundImage: AssetImage('assets/images/ebay1.png'),
                  //
                  //           )
                  //       ),
                  //       decoration: BoxDecoration(
                  //         shape: BoxShape.circle,
                  //         boxShadow: [
                  //           BoxShadow(
                  //             blurRadius: 6,
                  //             spreadRadius: 7,
                  //             color: Colors.grey,
                  //
                  //           )
                  //         ],
                  //         border: Border.all(
                  //           width: 1,
                  //           color: Colors.black,
                  //         ),
                  //       ),
                  //     ),
                  //     Text("Ebay",style: text1())
                  //   ],
                  // ),
                  // Column(
                  //   children: [
                  //     Container(
                  //       height: 55,
                  //       width: 55,
                  //       margin: EdgeInsets.only(left:9,top:15,bottom:8,right: 15),
                  //       child:InkWell(
                  //           onTap: (){
                  //
                  //           },
                  //           child: CircleAvatar(
                  //             radius: 30,
                  //             backgroundImage: AssetImage('assets/images/jio2.png'),
                  //
                  //           )
                  //       ),
                  //       decoration: BoxDecoration(
                  //         shape: BoxShape.circle,
                  //         boxShadow: [
                  //           BoxShadow(
                  //             blurRadius: 6,
                  //             spreadRadius: 7,
                  //             color: Colors.grey,
                  //
                  //           )
                  //         ],
                  //         border: Border.all(
                  //           width: 1,
                  //           color: Colors.black,
                  //         ),
                  //       ),
                  //     ),
                  //     Text("Jio",style: text1())
                  //   ],
                  // ),
                  // Column(
                  //   children: [
                  //     Container(
                  //       height: 55,
                  //       width: 55,
                  //       margin: EdgeInsets.only(left:9,top:15,bottom:8,right: 15),
                  //       child:InkWell(
                  //           onTap: (){
                  //
                  //           },
                  //           child: CircleAvatar(
                  //             radius: 30,
                  //             backgroundImage: AssetImage('assets/images/paytm1.png'),
                  //
                  //           )
                  //       ),
                  //       decoration: BoxDecoration(
                  //         shape: BoxShape.circle,
                  //         boxShadow: [
                  //           BoxShadow(
                  //             blurRadius: 6,
                  //             spreadRadius: 7,
                  //             color: Colors.grey,
                  //
                  //           )
                  //         ],
                  //         border: Border.all(
                  //           width: 1,
                  //           color: Colors.black,
                  //         ),
                  //       ),
                  //     ),
                  //     Text("Paytm",style: text1())
                  //   ],
                  // ),
                  // Column(
                  //   children: [
                  //     Container(
                  //       height: 55,
                  //       width: 55,
                  //       margin: EdgeInsets.only(left:9,top:15,bottom:8,right: 15),
                  //       child:InkWell(
                  //           onTap: (){
                  //
                  //           },
                  //           child: CircleAvatar(
                  //             radius: 30,
                  //             backgroundImage: AssetImage('assets/images/myntra.png'),
                  //
                  //           )
                  //       ),
                  //       decoration: BoxDecoration(
                  //         shape: BoxShape.circle,
                  //         boxShadow: [
                  //           BoxShadow(
                  //             blurRadius: 6,
                  //             spreadRadius: 7,
                  //             color: Colors.grey,
                  //
                  //           )
                  //         ],
                  //         border: Border.all(
                  //           width: 1,
                  //           color: Colors.black,
                  //         ),
                  //       ),
                  //     ),
                  //     Text("Myntra",style: text1())
                  //   ],
                  // ),
                ],
              ),
            ),

            SizedBox(height: 25),

            Center(child: Text('Follow us',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w300,color: Colors.white),)),

            SizedBox(height: 40,)

          ],
        ),
      ),
    );

  Widget sponser(image, text) {
    return Column(
      children: [
        SizedBox(width: 100),
        Container(
          height: 55,
          width: 55,
          margin: EdgeInsets.only(left:12,right:10,top:15,bottom:8),
          child: InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => Flipkart()));
              },
              child: CircleAvatar(
                radius: 30,
                backgroundImage: AssetImage(image),

              )),
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  blurRadius: 6,
                  spreadRadius: 7,
                  color: Colors.grey,
                )
              ],
              border: Border.all(
                  width: 1,
                  color: Colors.black
              )
          ),
        ),
        Text(text,style: text1(),)
      ],
    );

  }
}
