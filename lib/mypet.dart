// import 'package:charts_flutter/flutter.dart';
import 'package:flutter/material.dart';
import 'package:petopia/repository/DataRepository.dart';
import 'package:petopia/home.dart';

import 'models/Pet.dart';

class MyPetPage extends StatefulWidget {

  MyPetPage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyPetPageState createState() => _MyPetPageState();
}

class _MyPetPageState extends State<MyPetPage> {
  final DataRepository repository = DataRepository();

  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter += 2;
    });
    repository.addPet(Pet(_counter.toString(), type:"cat"));
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Pet Records      '),
          automaticallyImplyLeading: false,
          bottom: TabBar(
            indicatorColor: Colors.white,
            tabs: [
              Tab(text: 'Lucas'),
              Tab(text: 'Kitty'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Center(child: buildTabBarView('Lucas')),
            Center(child: buildTabBarView('Kitty')),
          ],
        ),
      ),
    );
  }

  Widget buildTabBarView(String tab) {
    return ListView(
      children: [
        buildCard('04/13/2021'),
        ListTile(
          title: Text('Weight'),
          leading: Icon(Icons.tour),
          trailing: Text('9.49lbs'),
        ),
        ListTile(
          title: Text('Calories'),
          leading: Icon(Icons.leaderboard),
          trailing: Text('97 CAL'),
        ),
        ListTile(
          title: Text('Next Deworming'),
          leading: Icon(Icons.pan_tool),
          trailing: Text('03/20/2021'),
        ),
        ListTile(
          title: Text('Next Vaccination'),
          leading: Icon(Icons.verified_user),
          trailing: Text('11/24/2021'),
        ),
      ],
    );
  }



  Widget buildCard(String tab) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          ListTile(
            // leading: Text("04/13/2021"),
            title: Center(child: Text(tab, style: TextStyle(fontSize: 25))),
          ),
          ButtonBar(
            alignment: MainAxisAlignment.start,
          ),
          Image.network('https://www.ctvnews.ca/polopoly_fs/1.5098407.1599687805!/httpImage/image.jpg_gen/derivatives/landscape_1020/image.jpg'),
        ],
      ),
    );
  }

}

const Color shrinePink400 = Color(0xFFEAA4A4);