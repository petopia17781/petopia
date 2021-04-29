import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:petopia/SizeConfig.dart';

class CustomSuffixIcon extends StatelessWidget {
  const CustomSuffixIcon({
    Key key,
    @required this.svgIcon,
  }) : super(key: key);

  final String svgIcon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        0,
        5 * SizeConfig.widthMultiplier,
        5 * SizeConfig.widthMultiplier,
        5 * SizeConfig.widthMultiplier,
      ),
      child: SvgPicture.asset(
        svgIcon,
        height: 4 * SizeConfig.widthMultiplier,
      ),
    );
  }
}