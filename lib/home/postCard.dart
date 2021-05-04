import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:petopia/SizeConfig.dart';
import 'package:petopia/models/Post.dart';
import 'package:petopia/models/User.dart';
import 'package:petopia/repository/UserRepository.dart';

class PostCard extends StatelessWidget {
  const PostCard({
    Key key,
    this.width = 140,
    this.aspectRatio = 1.02,
    @required this.post,
  }) : super(key: key);

  final double width, aspectRatio;
  final Post post;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return StreamBuilder<UserData>(
      stream: UserDataRepository(uid: post.uid).getUserData(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          UserData userData = snapshot.data;
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 2 * SizeConfig.widthMultiplier),
            child: SizedBox(
              width: 30 * SizeConfig.widthMultiplier,
              child: GestureDetector(
                onTap: () {},
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.all(0 * SizeConfig.widthMultiplier),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          // picture
                          Hero(
                            tag: post.reference,
                            child: AspectRatio(
                                aspectRatio: 1.35,
                                child: Image.network(post.mediaUrl)
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 3 * SizeConfig.widthMultiplier),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Text(
                                  post.description,
                                  style: TextStyle(color: Colors.black),
                                  maxLines: 2,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      userData.username,
                                      style: TextStyle(
                                        fontSize: 1.35 * SizeConfig.textMultiplier,
                                        fontWeight: FontWeight.w600,
                                        color: colorScheme.primary,
                                      ),
                                    ),
                                    InkWell(
                                      borderRadius: BorderRadius.circular(50),
                                      onTap: () {},
                                      child: Container(
                                        padding: EdgeInsets.all(1 * SizeConfig.widthMultiplier),
                                        height: 5 * SizeConfig.heightMultiplier,
                                        width: 5 * SizeConfig.widthMultiplier,
                                        decoration: BoxDecoration(
                                          color: true
                                              ? colorScheme.primary.withOpacity(0.15)
                                              : colorScheme.secondary.withOpacity(0.1),
                                          shape: BoxShape.circle,
                                        ),
                                        child: SvgPicture.asset(
                                          "assets/icons/Heart Icon_2.svg",
                                          color: true
                                              ? Colors.red
                                              : Colors.grey.withOpacity(0.5),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}