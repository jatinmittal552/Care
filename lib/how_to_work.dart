import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:practice/sidebar.dart';

class How_to_Work extends StatefulWidget{
  @override
  State<How_to_Work> createState() => _How_to_Work();
}

class _How_to_Work extends State<How_to_Work> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideBar(),
      appBar: AppBar(
        title: Text('How its Work'),

      ),
    );
  }
}