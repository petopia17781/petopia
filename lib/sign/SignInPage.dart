import 'package:flutter/material.dart';
import 'package:petopia/SizeConfig.dart';

import 'components/SignInForm.dart';
import 'components/SnsOptionCard.dart';

class SignInPage extends StatelessWidget {

  final Function toggleView;
  SignInPage({this.toggleView});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: 5 * SizeConfig.widthMultiplier),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 2 * SizeConfig.heightMultiplier),
                Text(
                  "Welcome To Petopia",
                  style: TextStyle(
                    color: Colors.black45,
                    fontSize: 3 * SizeConfig.textMultiplier,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 1 * SizeConfig.heightMultiplier),
                Text(
                  "Sign in with your email and password  \nor continue with social media",
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 3 * SizeConfig.heightMultiplier),
                SignForm(),
                SizedBox(height: 3 * SizeConfig.heightMultiplier),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SnsOptionCard(
                      icon: "assets/icons/google-icon.svg",
                      press: () {},
                    ),
                    SnsOptionCard(
                      icon: "assets/icons/facebook-2.svg",
                      press: () {},
                    ),
                    SnsOptionCard(
                      icon: "assets/icons/twitter.svg",
                      press: () {},
                    ),
                  ],
                ),
                SizedBox(height: 2 * SizeConfig.heightMultiplier),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don’t have an account? ",
                      style: TextStyle(fontSize: 1.75 * SizeConfig.textMultiplier),
                    ),
                    GestureDetector(
                      onTap: toggleView,
                      child: Text(
                        "Sign Up",
                        style: TextStyle(
                            fontSize: 1.75 * SizeConfig.textMultiplier,
                            color: colorScheme.primary),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 2 * SizeConfig.heightMultiplier),
              ],
            ),
          ),
        ),
      ),
    );
  }
}