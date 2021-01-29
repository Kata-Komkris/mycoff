import 'package:flutter/material.dart';

class CheckBill extends StatefulWidget {

  @override
  _CheckBillState createState() => _CheckBillState();
}

class _CheckBillState extends State<CheckBill> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xffEED9B9),
        iconTheme: IconThemeData(color: Color(0xff623B28)),
        ),
    );
  }
}