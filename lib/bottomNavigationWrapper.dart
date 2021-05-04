import 'package:flutter/material.dart';
import 'package:petopia/models/User.dart';
import 'package:petopia/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:petopia/home/home.dart';
import 'package:petopia/store.dart';
import 'package:petopia/mypet.dart';
import 'package:petopia/nearby.dart';
import 'package:petopia/profile/profileWrapper.dart';

class BottomNavigation extends StatefulWidget {
  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _selectedIndex = 0;
  static List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    StorePage(title: "Store"),
    MyPetPage(title: "My Pet"),
    NearbyPage(title: "Nearby"),
    StreamProvider<User>.value(
        value: AuthService().user,
        initialData: null,
        child: ProfileWrapper()
    )
  ];

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      // appBar: getAppBar(context),
        body: Center(child: _widgetOptions.elementAt(_selectedIndex)),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: colorScheme.primary,
          currentIndex: _selectedIndex,
          selectedItemColor: colorScheme.onSurface,
          unselectedItemColor: colorScheme.onSurface.withOpacity(.60),
          selectedLabelStyle: textTheme.caption,
          unselectedLabelStyle: textTheme.caption,
          onTap: (value) {
            setState(() => _selectedIndex = value);
          },
          items: [
            BottomNavigationBarItem(
              title: Text('Home'),
              icon: Icon(Icons.home),
            ),
            BottomNavigationBarItem(
              title: Text('Store'),
              icon: Icon(Icons.store),
            ),
            BottomNavigationBarItem(
              title: Text('My Pet'),
              icon: Icon(Icons.pets),
            ),
            BottomNavigationBarItem(
              title: Text('Nearby'),
              icon: Icon(Icons.location_on_rounded),
            ),
            BottomNavigationBarItem(
              title: Text('Profile'),
              icon: Icon(Icons.person),
            ),
          ],
        ));
  }
}
