import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ownerapp/ownerLogin.dart';

class OwnerSignUpPage extends StatefulWidget {
  @override
  _OwnerSignUpPageState createState() => _OwnerSignUpPageState();
}

class _OwnerSignUpPageState extends State<OwnerSignUpPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  TextEditingController _displayName = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmedpasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffEED9B9),
        body: Form(
            key: _formkey,
            child: Stack(children: [
              Container(
                  height: double.infinity,
                  width: double.infinity,
                  child: SingleChildScrollView(
                      physics: AlwaysScrollableScrollPhysics(),
                      padding: EdgeInsets.symmetric(
                        horizontal: 40.0,
                        vertical: 50.0,
                      ),
                      child: Column(children: <Widget>[
                        Text(
                          "Sign Up",
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
                                  controller: _displayName,
                                  decoration: InputDecoration(
                                      hintText: "User Name",
                                      border: InputBorder.none),
                                  validator: (String val) {
                                    if (val.isEmpty) {
                                      return "Please enter some text";
                                    }
                                    return null;
                                  },
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
                                  controller: _emailController,
                                  decoration: InputDecoration(
                                      hintText: "email",
                                      border: InputBorder.none),
                                  validator: (String val) {
                                    if (val.isEmpty) {
                                      return "Please enter your email";
                                    }
                                    return null;
                                  },
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
                                  controller: _passwordController,
                                  obscureText: true,
                                  decoration: InputDecoration(
                                      hintText: "password",
                                      border: InputBorder.none),
                                  validator: (String val) {
                                    if (val.isEmpty) {
                                      return "Please enter some text";
                                    }
                                    if(val.length < 8){
                                      return "weak-password";
                                    }
                                    return null;
                                  },
                                ),
                              )),
                        ),
                 /*       SizedBox(height: 30.0),
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
                              controller: _confirmedpasswordController,
                              obscureText: true,
                              decoration: InputDecoration(
                                  hintText: "Confirmed password",
                                  border: InputBorder.none),

                               validator: (String val) {
                                    if (val.isEmpty) {
                                      return "Please enter some text";
                                    }
                                    return null;
                                  },
                            ),
                          )),
                    ),*/
                        SizedBox(height: 30.0),
                        Container(
                          width: 300.0,
                          height: 40.0,
                          child: RaisedButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                                side: BorderSide(color: Color(0xff623B28))),
                            onPressed: () async {
                              if (_formkey.currentState.validate()) {
                                _register();
                              }
                            },
                            color: Color(0xff623B28),
                            textColor: Colors.white,
                            child:
                                Text("Sign Up", style: TextStyle(fontSize: 20)),
                          ),
                        ),
                        SizedBox(height: 40.0),
                        Container(
                            height: 190.0, child: Image.asset("images/cup.png"))
                      ])))
            ])));
  }

  void _register() async {
    final User user = (await _auth.createUserWithEmailAndPassword(
            email: _emailController.text, password: _passwordController.text))
        .user;
    if (user != null) {
      if (!user.emailVerified) {
        await user.sendEmailVerification();
      }
      await user.updateProfile(displayName: _displayName.text);
      final user1 = _auth.currentUser;
      showDialog(
          context: context,
          builder: (context) {
            Future.delayed(Duration(seconds: 1), () {
              Navigator.of(context)
                  .pushReplacement(MaterialPageRoute(builder: (context) {
                return OwnerLogin();
              }));
            });

            return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15.0))),
              title: Icon(
                Icons.check,
                color: Color(0xff623B28),
                size: 95.0,
              ),
              content: Text(
                "    Sign Up Complete  ",
                style: TextStyle(
                  color: Color(0xff623B28),
                  fontFamily: "Roboto",
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          });
    }
  }
}
