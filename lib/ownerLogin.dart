import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ownerapp/owenrSignUp.dart';
import 'package:ownerapp/ownerMenu.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ownerapp/checkBill.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ownerapp/ownerComment.dart';
import 'package:ownerapp/ownerLogin.dart';

class OwnerLogin extends StatefulWidget {
  @override
  _OwnerLoginState createState() => _OwnerLoginState();
}

class _OwnerLoginState extends State<OwnerLogin> {
  bool check = false;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldkey,
        backgroundColor: Color(0xffEED9B9),
        body:Form(
        key: _formkey,
        child:Stack(children: [
          Container(
              //height: double.infinity,
              width: double.infinity,
              child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                    horizontal: 40.0,
                    vertical: 50.0,
                  ),
                  child: Column(children: <Widget>[
                    Text(
                      "Sign In",
                      style: TextStyle(
                        color: Color(0xff623B28),
                        fontSize: 30.0,
                        fontFamily: "Roboto",
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    Center(
                      child: Container(
                          width: 600.0,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey[300],
                                    offset: Offset(2, 1),
                                    blurRadius: 5)
                              ]),
                          child: ListTile(
                            title: TextFormField(
                              controller: _emailController,
                              decoration: InputDecoration(
                                  hintText: "email",
                                  border: InputBorder.none),

                               validator: (String input){

                               if(input.isEmpty){

                                return "Enter Email";
                              }
                                return null;
                              }
                            ),
                          )),
                    ),

                    SizedBox(height: 30.0),
                    Center(
                      child: Container(
                          width: 600.0,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey[300],
                                    offset: Offset(2, 1),
                                    blurRadius: 5)
                              ]),
                          child: ListTile(
                            title: TextFormField(
                              obscureText: true,
                              controller: _passwordController,
                              decoration: InputDecoration(
                                  hintText: "password",
                                  border: InputBorder.none),
                              validator: (String val){
                                if(val.isEmpty){
                                return("Enter password");
                              }
                                return null;
                              }
                            ),
                          )),
                    ),
                    SizedBox(height: 10.0),
                    Container(
                      child: Row(
                          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Checkbox(
                              activeColor: Colors.grey,
                              value: check,
                              onChanged: (bool value) {
                                setState(() {
                                  check = value;
                                });
                              },
                            ),
                            Text(
                              'Remember account',
                              style: TextStyle(
                                  color: Color(0xff623B28),
                                  fontFamily: "Roboto",
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.bold),
                            ),
                           /* SizedBox(width: 40.0),
                            GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ForgotPassword()));
                                },
                                child: Text(
                                  "Forgot Password?",
                                  style: TextStyle(
                                      color: Color(0xff623B28),
                                      fontFamily: "Roboto",
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.bold),
                                )),*/
                          ]),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(148.0, 0.0, 0.0, 0.0),
                      child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => OwnerSignUpPage()));
                          },
                          child: Text(
                            "don't have an account?",
                            style: TextStyle(
                                color: Color(0xff623B28),
                                fontFamily: "Roboto",
                                fontSize: 12.0,
                                fontWeight: FontWeight.bold),
                          )),
                    ),
                    SizedBox(height: 20.0),
                    Container(
                      width: 300.0,
                      height: 40.0,
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(color: Color(0xff623B28))),
                            color: Color(0xff623B28),
                            textColor: Colors.white,
                            child: Text("Login", style: TextStyle(fontSize: 20)),
                            onPressed: () async {
                          if(_formkey.currentState.validate()) {
                            _signinWithEmailPassword();
                          }
                          
                        },
                        
                      ),
                    ),
                    SizedBox(height: 20.0),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      child: Container(
                          height: 3.0, width: 450.0, color: Color(0xff623B28)),
                    ),
                    SizedBox(height: 10.0),
                    /*Text(
                      "OR",
                      style: TextStyle(
                          color: Color(0xff623B28),
                          fontFamily: "Roboto",
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold),
                    ),*/
                    SizedBox(height: 10.0),
                  /*  Container(
                        height: 60.0,
                        padding: EdgeInsets.fromLTRB(55.0, 0.0, 0.0, 0.0),
                        child: Row(
                          children: <Widget>[
                             Image.asset("images/facebook_brown.png"),
                            SizedBox(width: 82.0),
                            GestureDetector(
                             child:Image.asset("images/google.png"),
                             onTap: () {
                               _signinWithGoogle();
                             },
                            )
                          ],
                        )),*/
                    SizedBox(height: 20.0),
                    Container(
                        height: 190.0, child: Image.asset("images/cup.png"))
                  ])))
        ])));
  }

  void _signinWithEmailPassword() async {
    try {
      final User user = (await _auth.signInWithEmailAndPassword(
        email: _emailController.text, 
        password: _passwordController.text)).user;
        if (!user.emailVerified) {
          await user.sendEmailVerification();
        }
        Navigator.of(context).push(MaterialPageRoute(builder: (_){
          return OwnerMenu(user: user);
        }));
    } catch (e) {
      _scaffoldkey.currentState.showSnackBar(SnackBar(
        content: Text("Failed to sign in with email or password"),
      ));
      print(e);
    }
  }
  
  
  
}

