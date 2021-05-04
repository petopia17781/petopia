import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:petopia/SizeConfig.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader(
      {Key key,
        @required this.username,
        this.avatar,
        this.facebook,
        this.twitter,
        @required this.follower,
        @required this.followee})
      : super(key: key);

  final String username, avatar;
  final String facebook, twitter;
  final int follower, followee;

  @override
  Widget build(BuildContext context) {

    return Container(
      color: shrinePink400,
      height: 30 * SizeConfig.heightMultiplier,
      child: Padding(
        padding: EdgeInsets.only(
            left: 30.0, right: 30.0, top: 5 * SizeConfig.heightMultiplier),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                // Avatar
                Container(
                  height: 11 * SizeConfig.heightMultiplier,
                  width: 22 * SizeConfig.widthMultiplier,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(avatar == null ? "https://images-na.ssl-images-amazon.com/images/I/31Rgh5fBqDL.jpg" : avatar))),
                ),
                SizedBox(
                  width: 5 * SizeConfig.widthMultiplier,
                ),
                // User name & SNS
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    // username
                    Text(
                      username,
                      style: TextStyle(
                          color: Colors.black38,
                          fontSize: 3 * SizeConfig.textMultiplier,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 1 * SizeConfig.heightMultiplier,
                    ),
                    // sns account
                    Row(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            SvgPicture.asset(
                              "assets/icons/facebook-2.svg",
                              color: Colors.black26,
                            ),
                            SizedBox(
                              width: 2 * SizeConfig.widthMultiplier,
                            ),
                            Text(
                              facebook == null ? "Tap to Link" : facebook,
                              style: TextStyle(
                                color: Colors.black26,
                                fontSize: 1.5 * SizeConfig.textMultiplier,
                              ),
                            ),
                            SizedBox(
                              width: 2 * SizeConfig.widthMultiplier,
                            ),
                            SvgPicture.asset(
                              "assets/icons/twitter.svg",
                              color: Colors.black26,
                            ),
                            SizedBox(
                              width: 2 * SizeConfig.widthMultiplier,
                            ),
                            Text(
                              twitter == null ? "Tap to Link" : twitter,
                              style: TextStyle(
                                color: Colors.black26,
                                fontSize: 1.5 * SizeConfig.textMultiplier,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                )
              ],
            ),
            SizedBox(
              height: 3 * SizeConfig.heightMultiplier,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  children: [
                    Text(
                      NumberFormat.compact().format(follower),
                      style: TextStyle(
                          color: Colors.black38,
                          fontSize: 3 * SizeConfig.textMultiplier,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Followers",
                      style: TextStyle(
                        color: Colors.black26,
                        fontSize: 1.9 * SizeConfig.textMultiplier,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      NumberFormat.compact().format(followee),
                      style: TextStyle(
                          color: Colors.black38,
                          fontSize: 3 * SizeConfig.textMultiplier,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Following",
                      style: TextStyle(
                        color: Colors.black26,
                        fontSize: 1.9 * SizeConfig.textMultiplier,
                      ),
                    ),
                  ],
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black26),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: GestureDetector(
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "EDIT PROFILE",
                        style: TextStyle(
                            color: Colors.black26,
                            fontSize: 1.8 * SizeConfig.textMultiplier),

                      ),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

const Color shrinePink400 = Color(0xFFEAA4A4);