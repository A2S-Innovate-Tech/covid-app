import 'package:covid_helpline_app/admin_panel/admin_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passController = TextEditingController();
  String buttonText = 'SignIn';
  @override
  void initState() {
    buttonText = 'SignIn';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Admin SignIn"),
        centerTitle: true,
        backgroundColor: Colors.indigoAccent,
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Enter Email',
                    enabledBorder: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(),
                    errorBorder: OutlineInputBorder(),
                  ),
                  validator: (String val) {
                    if (val.isEmpty) {
                      return "Please enter email";
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 25,
                ),
                TextFormField(
                  controller: _passController,
                  decoration: InputDecoration(
                    labelText: 'Enter Password',
                    enabledBorder: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(),
                  ),
                  validator: (String val) {
                    if (val.isEmpty) {
                      return "Please enter password";
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 15,
                ),
                MaterialButton(
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      _signInAccount();
                      setState(() {
                        _emailController.clear();
                        _passController.clear();
                      });
                      try {
                        final result =
                            await InternetAddress.lookup('google.com');
                        if (result.isNotEmpty &&
                            result[0].rawAddress.isNotEmpty) {
                          setState(() {
                            buttonText = 'Signing....';
                          });
                        }
                      } on SocketException catch (_) {
                        showLoaderDialog1(context);
                      }
                    }
                  },
                  child: Text("$buttonText",
                      style: TextStyle(color: Colors.white)),
                  color: Colors.indigo,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // showLoaderDialog(BuildContext context) {
  //   AlertDialog alert = AlertDialog(
  //     content: new Row(
  //       children: [
  //         CircularProgressIndicator(),
  //         Container(
  //             margin: EdgeInsets.only(left: 7), child: Text("Loading...")),
  //       ],
  //     ),
  //   );
  //   showDialog(
  //     barrierDismissible: false,
  //     context: context,
  //     builder: (BuildContext context) {
  //       return alert;
  //     },
  //   );
  // }

  showLoaderDialog1(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: Text('Please Connect to Internet'),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('OK'))
      ],
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void _signInAccount() async {
    try {
      final User user = (await _auth.signInWithEmailAndPassword(
              email: _emailController.text, password: _passController.text))
          .user;
      if (!user.emailVerified) {
        await user.sendEmailVerification();
      }
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (_) => AdminPage()));
    } catch (e) {
      print(e);
    }
  }
}
