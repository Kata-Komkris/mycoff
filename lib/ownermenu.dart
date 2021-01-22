import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ownerapp/Data.dart';
import 'package:ownerapp/checkBill.dart';
import 'Data.dart';

class OwnerMenu extends StatefulWidget {
  final User user;

  const OwnerMenu({Key key, this.user}) : super(key: key);

  @override
  _OwnerMenuState createState() => _OwnerMenuState();
}

class _OwnerMenuState extends State<OwnerMenu> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffEED9B9),
        appBar: AppBar(
          backgroundColor: Color(0xffEED9B9),
          iconTheme: IconThemeData(color: Color(0xff623B28)),
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Text(
            "Manager",
            style: TextStyle(
                color: Color(0xff623B28), fontWeight: FontWeight.bold),
          ),
        ),
        body: GetBuilder<DataController>(
          init: DataController(),
          builder: (value) {
            return new FutureBuilder(
              future: value.getData("getOrder"),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                      child: CircularProgressIndicator(
                    backgroundColor: Colors.white,
                  ));
                } else {
                  return new ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                          child: GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => CheckBill()));
                              },
                              child: Container(
                                height: 80.0,
                                width: 40.0,
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            /*  Padding(padding: EdgeInsets.only(left:20.0),
                                child: Text("Queue:${snapshot.data[index].data()['queue']}",
                                        style: TextStyle(color: Color(0xff623B28),
                                        fontWeight: FontWeight.bold, fontSize: 16.0)),
                              ),*/

                                            Padding(
                                              padding:
                                                  EdgeInsets.only(left: 20.0),
                                              child: Text(
                                                  "Total:${snapshot.data[index].data()['Total']}",
                                                  style: TextStyle(
                                                      color: Color(0xff623B28),
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16.0)),
                                            ),

                                            /* Padding(padding: EdgeInsets.only(left:20.0),
                                child: Text("Total:${snapshot.data[index].data()['total']}",
                                          style: TextStyle(color: Color(0xff623B28),
                                          fontWeight: FontWeight.bold, fontSize: 16.0)),
                              ), */
                                          ]),
                                      /*Padding(
                                        padding: EdgeInsets.only(left: 20.0),
                                        child: Text(
                                            "Date&Time:${snapshot.data[index].data()['Date']}",
                                            style: TextStyle(
                                                color: Color(0xff623B28),
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16.0)),
                                      ),*/
                                    ]),
                              )));
                    },
                  );
                }
              },
            );
          },
        ));
  }
}
