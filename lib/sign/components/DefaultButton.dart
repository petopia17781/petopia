import 'package:flutter/material.dart';
import 'package:petopia/SizeConfig.dart';

class DefaultButton extends StatelessWidget {
  const DefaultButton({
    Key key,
    this.text,
    this.press,
  }) : super(key: key);
  final String text;
  final Function press;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return SizedBox(
      width: double.infinity,
      height: 6.5 * SizeConfig.heightMultiplier,
      child: FlatButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        color: colorScheme.primary,
        onPressed: press,
        child: Text(
          text,
          style: TextStyle(
            fontSize: 2.5 * SizeConfig.textMultiplier,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}