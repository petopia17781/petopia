import 'package:flutter/material.dart';
import 'package:petopia/SizeConfig.dart';

import 'components/CompleteProfileForm.dart';

class CompleteProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                    "Complete Profile",
                    style: TextStyle(
                      color: Colors.black45,
                      fontSize: 3 * SizeConfig.textMultiplier,
                      fontWeight: FontWeight.bold,
                    )
                ),
                SizedBox(height: 1 * SizeConfig.heightMultiplier),
                Text(
                  "Complete your details or continue  \nwith social media",
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 3 * SizeConfig.heightMultiplier),
                CompleteProfileForm(),
                SizedBox(height: 3 * SizeConfig.heightMultiplier),
                Text(
                  "By continuing your confirm that you agree \nwith our Term and Condition",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.caption,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
