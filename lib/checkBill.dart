import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:ownerapp/checkBill.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ownerapp/ownerComment.dart';
import 'package:ownerapp/ownerLogin.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'dart:async';
import 'ownerMenu.dart';

class CheckBill extends StatefulWidget {
  final thisco;

  CheckBill({this.thisco});
  @override
  _CheckBillState createState() => _CheckBillState();
}

class _CheckBillState extends State<CheckBill> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  String checkNoteNull = "";
  String checkSizedNull = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xffEED9B9),
        iconTheme: IconThemeData(color: Color(0xff623B28)),
        centerTitle: true,
        title: Text(
          "Order",
          style:
              TextStyle(color: Color(0xff623B28), fontWeight: FontWeight.bold),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('getOrder').snapshots(),
          builder: (contex, snapshots) {
            if (snapshots.connectionState == ConnectionState.waiting) {
              return Center(
                  child: CircularProgressIndicator(
                backgroundColor: Colors.white,
              ));
            } else {
              final list = snapshots.data.docs;
              int thisco = widget.thisco;
              var DD = list[thisco]["Menu"];
              return ListView.builder(
                itemCount: DD.length,
                itemBuilder: (context, index) {
                  var hD = list[thisco]["Menu"];

                  if (hD[index]["note"] == null) {
                    checkNoteNull = "Don't Have Note";
                  } else {
                    checkNoteNull = hD[index]["note"];
                  }
                  if (hD[index]["size"] == null) {
                    checkSizedNull = "-";
                  } else {
                    checkSizedNull = hD[index]["size"];
                  }
                  return Card(
                      child: Container(
                    height: 100.0,
                    width: 40.0,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left: 20.0),
                                  child: Text(
                                    "${hD[index]["item"]}",
                                    style: TextStyle(
                                        color: Color(0xff623B28),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16.0),
                                    textAlign: TextAlign.right,
                                  ),
                                ),
                                Expanded(
                                  //padding: EdgeInsets.only(right: 20.0),
                                  child: Text(
                                    "${checkSizedNull}",
                                    style: TextStyle(
                                        color: Color(0xff623B28),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16.0),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Expanded(
                                  //padding: EdgeInsets.only(right: 20.0),
                                  child: Text(
                                    "${hD[index]["qty"]}",
                                    style: TextStyle(
                                        color: Color(0xff623B28),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16.0),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ]),
                          Padding(
                            padding: EdgeInsets.only(left: 25.0),
                            child: Text(
                              "note: ${checkNoteNull}",
                              style: TextStyle(
                                  color: Color(0xff623B28),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.0),
                              textAlign: TextAlign.right,
                            ),
                          ),
                          /*Padding(
                                padding: EdgeInsets.only(left: 20.0),
                                child: Container(
                                  child: Text(
                                      "Date&Time:${list[index].data()["Total"]}",
                                      style: TextStyle(
                                          color: Color(0xff623B28),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16.0)),
                                ),
                              ),*/
                        ]),
                  ));
                },
              );
            }
          }),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     Alert(
      //       context: context,
      //       type: AlertType.warning,
      //       title: "Are You Sure",
      //       buttons: [
      //         DialogButton(
      //           child: Text(
      //             "Cancle",
      //             style: TextStyle(color: Colors.white, fontSize: 20),
      //           ),
      //           onPressed: () => Navigator.pop(context),
      //           color: Color(0xffFF6767),
      //         ),
      //         DialogButton(
      //           child: Text(
      //             "Confirm",
      //             style: TextStyle(color: Colors.white, fontSize: 20),
      //           ),
      //           onPressed: () async {
      //             final user = _auth.currentUser;

      //             Navigator.of(context)
      //                 .pushReplacement(MaterialPageRoute(builder: (_) {
      //               return OwnerMenu(
      //                 user: user,
      //               );
      //             }));
      //           },
      //           color: Color(0xff99DC79),
      //         ),
      //       ],
      //     ).show();
      //   },
      //   backgroundColor: Color(0xff623B28),
      //   child: Icon(Icons.done),
      // ),
    );
  }
}

// DeleteData(BuildContext context,String key) {

// }
