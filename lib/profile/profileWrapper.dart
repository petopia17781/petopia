import 'package:flutter/material.dart';
import 'package:petopia/models/User.dart';
import 'package:petopia/profile/profile.dart';
import 'package:petopia/sign/SignWrapper.dart';
import 'package:provider/provider.dart';


class ProfileWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);
    // return either Profile or Authenticate widget
    if (user == null) {
      return SignWrapper();
    } else {
      return ProfilePage(title: "My Profile");
    }
  }
}
