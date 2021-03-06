import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ownerapp/checkBill.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ownerapp/ownerComment.dart';
import 'package:ownerapp/ownerLogin.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class OwnerMenu extends StatefulWidget {
  final User user;

  const OwnerMenu({Key key, this.user}) : super(key: key);

  @override
  _OwnerMenuState createState() => _OwnerMenuState();
}

class _OwnerMenuState extends State<OwnerMenu> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Color(0xffEED9B9),
      appBar: AppBar(
        backgroundColor: Color(0xffEED9B9),
        iconTheme: IconThemeData(color: Color(0xff623B28)),
        //automaticallyImplyLeading: ,
        centerTitle: true,
        title: Text(
          "Manager",
          style:
              TextStyle(color: Color(0xff623B28), fontWeight: FontWeight.bold),
        ),
      ),
      drawer: Drawer(
        child: Column(
          children: <Widget>[
            Container(
              height: 124,
              width: double.infinity,
              padding: EdgeInsets.all(20.0),
              color: Color(0xffEED9B9),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "user: ${widget.user.displayName}",
                      style: TextStyle(
                          color: Color(0xff623B28),
                          fontFamily: "Roboto",
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0),
                    ),
                    SizedBox(height: 5.0),
                    Text(
                      "email: ${widget.user.email}",
                      style: TextStyle(
                          color: Color(0xff623B28),
                          fontFamily: "Roboto",
                          fontWeight: FontWeight.bold,
                          fontSize: 15.0),
                    ),
                  ]),
            ),
            SizedBox(
              height: 14.0,
            ),
            GestureDetector(
                child: ListTile(
                    onTap: () async {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  OwnerComment()));
                    },
                    leading: Icon(Icons.comment),
                    title: Text(
                      "Comment",
                      style: TextStyle(
                          color: Color(0xff623B28),
                          fontFamily: "Roboto",
                          fontWeight: FontWeight.bold,
                          fontSize: 15.0),
                    ))),
            SizedBox(
              height: 2.0,
            ),
            GestureDetector(
                child: ListTile(
                    onTap: () async {
                      _signOut().whenComplete(() {
                        Navigator.of(context)
                            .pushReplacement(MaterialPageRoute(builder: (_) {
                          return OwnerLogin();
                        }));
                      });
                    },
                    leading: Icon(Icons.logout),
                    title: Text(
                      "Logout",
                      style: TextStyle(
                          color: Color(0xff623B28),
                          fontFamily: "Roboto",
                          fontWeight: FontWeight.bold,
                          fontSize: 15.0),
                    ))),
          ],
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: firebaseFirestore.collection("getOrder").snapshots(),
        builder:
            (BuildContext contex, AsyncSnapshot<QuerySnapshot> querySnapshot) {
          if (querySnapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child: CircularProgressIndicator(
              backgroundColor: Colors.white,
            ));
          } else {
            final list = querySnapshot.data.docs;
            return new ListView.builder(
              itemCount: list.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => CheckBill(
                                thisco: index,
                              )));
                    },
                    child: Card(
                        child: Container(
                      height: 80.0,
                      width: 40.0,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(left: 20.0),
                                    child: Text(
                                      "Form ${list[index].data()["User"]}",
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
                                      "Total:${list[index].data()["Total"]}",
                                      style: TextStyle(
                                          color: Color(0xff623B28),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16.0),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  IconButton(
                                    color: Color(0xff623B28),
                                    icon: Icon(Icons.delete),
                                    onPressed: () {
                                      Alert(
                                        context: context,
                                        type: AlertType.warning,
                                        title: "Are You Sure",
                                        buttons: [
                                          DialogButton(
                                            child: Text(
                                              "Cancle",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20),
                                            ),
                                            onPressed: () =>
                                                Navigator.pop(context),
                                            color: Color(0xffFF6767),
                                          ),
                                          DialogButton(
                                            child: Text(
                                              "Confirm",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20),
                                            ),
                                            onPressed: () async {
                                              querySnapshot
                                                  .data.docs[index].reference
                                                  .delete()
                                                  .then((value) =>
                                                      Navigator.pop(context));

                                              // final user = _auth.currentUser;

                                              // Navigator.of(context)
                                              //     .pushReplacement(MaterialPageRoute(builder: (_) {
                                              //   return OwnerMenu(
                                              //     user: user,
                                              //   );
                                              // }));
                                            },
                                            color: Color(0xff99DC79),
                                          ),
                                        ],
                                      ).show();
                                    },
                                  ),
                                ]),

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
                    )));
              },
            );
          }
        },
      ),
    );
  }

  Future _signOut() async {
    await _auth.signOut();
  }
}
