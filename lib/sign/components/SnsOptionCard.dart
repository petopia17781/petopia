import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:petopia/SizeConfig.dart';

class SnsOptionCard extends StatelessWidget {
  const SnsOptionCard({
    Key key,
    this.icon,
    this.press,
  }) : super(key: key);

  final String icon;
  final Function press;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Container(
        margin:
        EdgeInsets.symmetric(horizontal: 3 * SizeConfig.widthMultiplier),
        padding: EdgeInsets.all(3 * SizeConfig.widthMultiplier),
        height: 5 * SizeConfig.heightMultiplier,
        width: 10 * SizeConfig.widthMultiplier,
        decoration: BoxDecoration(
          color: Color(0xFFF5F6F9),
          shape: BoxShape.circle,
        ),
        child: SvgPicture.asset(icon),
      ),
    );
  }
}