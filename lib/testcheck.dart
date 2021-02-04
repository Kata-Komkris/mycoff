// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:ownerapp/checkBill.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:ownerapp/ownerComment.dart';
// import 'package:ownerapp/ownerLogin.dart';
// import 'package:rflutter_alert/rflutter_alert.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';


// class ItemsList extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     // get the course document using a stream
//     Stream<DocumentSnapshot> courseDocStream = Firestore.instance
//         .collection('getOreder')
//         .doc()
//         .snapshots();

//     return StreamBuilder<DocumentSnapshot>(
//         stream: courseDocStream,
//         builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
//           if (snapshot.connectionState == ConnectionState.active) {

//             // get course document
//             var courseDocument = snapshot.data.data;

//             // get sections from the document
//             var sections = courseDocument['Menu'];

//             // build list using names from sections
//             return ListView.builder(
//               itemCount: sections != null ? sections.length : 0,
//               itemBuilder: (_, int index) {
//                 print(sections[index]['name']);
//                 return ListTile(title: Text(sections[index]['name']));
//               },
//             );
//           } else {
//             return Container();
//           }