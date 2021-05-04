import 'package:flutter/material.dart';
import 'package:petopia/SizeConfig.dart';
import 'package:petopia/sign/components/DefaultButton.dart';
import 'package:petopia/sign/components/FormError.dart';

import 'SuffixIcon.dart';

class CompleteProfileForm extends StatefulWidget {
  @override
  _CompleteProfileFormState createState() => _CompleteProfileFormState();
}

class _CompleteProfileFormState extends State<CompleteProfileForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> errors = [];
  String userName;
  String description;

  void addError({String error}) {
    if (!errors.contains(error))
      setState(() {
        errors.add(error);
      });
  }

  void removeError({String error}) {
    if (errors.contains(error))
      setState(() {
        errors.remove(error);
      });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildUserNameFormField(),
          SizedBox(height: 5 * SizeConfig.heightMultiplier),
          buildDescriptionFormField(),
          FormError(errors: errors),
          SizedBox(height: 5 * SizeConfig.heightMultiplier),
          DefaultButton(
            text: "continue",
            press: () {
              if (_formKey.currentState.validate()) {

              }
            },
          ),
        ],
      ),
    );
  }

  TextFormField buildUserNameFormField() {
    return TextFormField(
      onSaved: (newValue) => userName = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: "Please Enter your user name");
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: "Please Enter your name");
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "User Name",
        hintText: "Enter your user name",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSuffixIcon(svgIcon: "assets/icons/User.svg"),
      ),
    );
  }

  TextFormField buildDescriptionFormField() {
    return TextFormField(
      onSaved: (newValue) => description = newValue,
      decoration: InputDecoration(
        labelText: "Description",
        hintText: "Describe yourself",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSuffixIcon(svgIcon: "assets/icons/Flash Icon.svg"),
      ),
    );
  }
}