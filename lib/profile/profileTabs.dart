import 'package:flutter/material.dart';
import 'package:petopia/SizeConfig.dart';
import 'package:petopia/profile/profileHeader.dart';

class ProfileTabs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Padding(
      padding: EdgeInsets.only(top: 30 * SizeConfig.heightMultiplier),
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: shrinePink400,
            flexibleSpace: SafeArea(
              child: TabBar(
                indicatorColor: colorScheme.onSurface,
                tabs: [
                  Tab(text: 'POSTS'),
                  Tab(text: 'FAVORITES'),
                  Tab(text: 'LIKED'),
                ],
              ),
            ),
          ),
          body: TabBarView(
            children: [
              Center(child: Text('POSTS')),
              Center(child: Text('FAVORITES')),
              Center(child: Text('LIKED')),
            ],
          ),
        ),
      ),
    );
  }
}