import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:practice/sidebar.dart';

class FAQ extends StatefulWidget{
  @override
  State<FAQ> createState() => _FAQ();
}

class _FAQ extends State<FAQ> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideBar(),
      appBar: AppBar(
        title: Text('FAQ'),

      ),
    );
  }
}