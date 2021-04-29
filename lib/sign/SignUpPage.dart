import 'package:flutter/material.dart';
import 'package:petopia/SizeConfig.dart';
import 'package:petopia/sign/components/SignUpForm.dart';

import 'components/SnsOptionCard.dart';

class SignUpPage extends StatelessWidget {

  final Function toggleView;
  SignUpPage({this.toggleView});

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
                    "Register Account",
                    style: TextStyle(
                      color: Colors.black45,
                      fontSize: 3 * SizeConfig.textMultiplier,
                      fontWeight: FontWeight.bold,
                    )
                ),
                SizedBox(height: 1 * SizeConfig.heightMultiplier),
                Text(
                  "Complete your details or continue \nwith social media",
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 3 * SizeConfig.heightMultiplier),
                SignUpForm(),
                SizedBox(height: 2 * SizeConfig.heightMultiplier),
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
                      "Already had an account? ",
                      style: TextStyle(fontSize: 1.75 * SizeConfig.textMultiplier),
                    ),
                    GestureDetector(
                      onTap: toggleView,
                      child: Text(
                        "Sign In",
                        style: TextStyle(
                            fontSize: 1.75 * SizeConfig.textMultiplier,
                            color: colorScheme.primary),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 2 * SizeConfig.heightMultiplier),
                Text(
                  'By continuing your confirm that you agree \nwith our Term and Condition',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.caption,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
