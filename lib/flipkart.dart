// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// class Flipkart extends StatelessWidget {  @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//
//       ),
//       body: Center(child: Text('go to flipkart app',style: TextStyle(fontSize: 13),)),
//     );
//   }
// }

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:practice/videoProgess.dart';
import 'package:practice/customSilder.dart';

class Flipkart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      ),
      body: Center(
        child: Stack(
          children: [
            VideoProgress(),
            Positioned(child: CustomSlider(),bottom: 0,left: 0,right: 0,),

          ],
        ),
      ),



      // body: Center(child: Text('Authenticate through google api')),
    );
  }
}