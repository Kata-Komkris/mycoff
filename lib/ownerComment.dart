import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class OwnerComment extends StatefulWidget {
  @override
  _OwnerCommentState createState() => _OwnerCommentState();
}

class _OwnerCommentState extends State<OwnerComment> {
  
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffEED9B9),
       key: _scaffoldKey, 
      appBar: AppBar(
        backgroundColor: Color(0xffEED9B9),
        iconTheme: IconThemeData(color: Color(0xff623B28)),
        //automaticallyImplyLeading: ,
        centerTitle: true,
        title: Text("Comment",
            style: TextStyle(color: Color(0xff623B28),fontWeight: FontWeight.bold),
        ),
        actions: [
            IconButton(
                icon: Icon(Icons.delete),
                color: Color(0xff623B28),
                onPressed: () {
                  setState(() {
                    
                  });
                })
          ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: firebaseFirestore.collection("comment").snapshots(),
       builder: (BuildContext contex, AsyncSnapshot<QuerySnapshot> querySnapshot) {
              if(querySnapshot.connectionState == ConnectionState.waiting){
                return Center(child: CircularProgressIndicator(backgroundColor: Colors.white,));
              }
              else{
                final list = querySnapshot.data.docs;
                return new ListView.builder(
                  itemCount: list.length,
                  itemBuilder: (BuildContext context, int index){
                    return GestureDetector(
                      onTap: () {
                          //Navigator.of(context).push(MaterialPageRoute(builder: (context) => CheckBill()));
                        },
                   child: Card(
                        child: Container(                       
                        height: 80.0,
                        width: 40.0,
                        child:Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children:[
                            
                              Padding(padding: EdgeInsets.only(left:20.0),
                                child: Text("Comment: ${list[index].data()["comment"]}",
                                          style: TextStyle(color: Color(0xff623B28),
                                          fontWeight: FontWeight.bold, fontSize: 16.0)),
                              ), 

                            ]
                            ),
                            
                          ]
                        ),          
                      )
                      
                    )
                    );
                     
                  },
                );
              }
        },
      )
    );
  }
}