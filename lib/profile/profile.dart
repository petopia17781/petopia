import 'package:flutter/material.dart';
import 'package:petopia/models/User.dart';
import 'package:petopia/profile/profileHeader.dart';
import 'package:petopia/profile/profileTabs.dart';
import 'package:petopia/repository/UserRepository.dart';
import 'package:petopia/services/auth.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final user = Provider.of<User>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorScheme.primary,
        title: const Text('Profile'),
        actions: <Widget>[
          new IconButton(
            icon: new Icon(Icons.logout),
            onPressed: () async {
              await _auth.signOut();
            },
          )
        ],
      ),
      body: StreamBuilder<UserData>(
        stream: UserDataRepository(uid: user.uid).getUserData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData userData = snapshot.data;
            return Stack(
              children: <Widget>[
                // header
                ProfileHeader(
                  username: userData.username,
                  follower: 15300,
                  followee: 314,
                ),
                // tab
                ProfileTabs()
              ],
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
