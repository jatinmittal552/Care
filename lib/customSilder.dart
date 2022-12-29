import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:practice/slidernavigator.dart';
import 'package:provider/provider.dart';
import 'package:practice/videoProgess.dart';

class CustomSlider extends StatefulWidget{
  @override
  State<CustomSlider> createState() => CustomSliderState();
}

class CustomSliderState extends State<CustomSlider> {
  var slidervalue = 0.1;

  void _onChanged(double val){
    setState(() {
      slidervalue = val;
    });
    final provider= context.read<SliderNavigator>().changer(val);
    // print('$VideoProgressState().progress');

    // final provider = context.read<SliderNavigator>().changer();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 50,
        margin: EdgeInsets.all(20),
        child: Slider(
          onChanged: _onChanged,
          value: slidervalue,
        ),

    );
  }
}