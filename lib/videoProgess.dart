import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:practice/slidernavigator.dart';
import 'package:provider/provider.dart';

class VideoProgress extends StatefulWidget{
  @override
  State<VideoProgress> createState() => _VideoProgressState();
}

class _VideoProgressState extends State<VideoProgress> {

  @override
  Widget build(BuildContext context) {
    double progress = context.watch<SliderNavigator>().isprogress;
    return Scaffold(
      body: Center(child: Text("Video Progress: ${progress.toStringAsFixed(2)}%",style: TextStyle(color: Colors.white,fontSize: 30),)),
    );
  }
}