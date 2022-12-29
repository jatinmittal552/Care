import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:practice/sidebar.dart';

class Profile extends StatefulWidget{
  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
   return Scaffold(
     drawer: SideBar(),
     appBar: AppBar(
       title: Text('Profile'),

     ),
   );
  }
}