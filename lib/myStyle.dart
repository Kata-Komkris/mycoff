import 'package:flutter/material.dart';

class MyStyle {

  Text storeName(String title) {
    return Text( title,
            style: TextStyle(
              height: 2, 
              fontSize: 50,
              fontFamily: 'RobotoMono',
              fontWeight: FontWeight.bold,
              color: Color(0xff623B28)),
          );
  }

   Container logoMain() {
    return Container(
            width: 150.0,
            child: Image.asset("images/logo.png"),);
  }
  MyStyle();
}