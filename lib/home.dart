import 'dart:async';
import 'package:flutter/material.dart';
import 'package:ownerapp/ownerLogin.dart';
import 'myStyle.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 1),
        () => Navigator.push(
            context, MaterialPageRoute(builder: (context) =>  OwnerLogin())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffEED9B9),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              MyStyle().logoMain(),
              MyStyle().storeName("Manager"),
            ],
          ),
        ));
  }
}
