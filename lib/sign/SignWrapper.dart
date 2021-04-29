import 'package:flutter/material.dart';
import 'package:petopia/sign/SignInPage.dart';
import 'package:petopia/sign/SignUpPage.dart';

class SignWrapper extends StatefulWidget {
  @override
  _SignWrapperState createState() => _SignWrapperState();
}

class _SignWrapperState extends State<SignWrapper> {

  bool showSignIn = true;

  void toggleView() {
    setState(() {
      showSignIn = !showSignIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn) {
      return SignInPage(toggleView: toggleView);
    } else {
      return SignUpPage(toggleView: toggleView);
    }
  }
}
