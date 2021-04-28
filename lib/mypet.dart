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
  List<bool> reminderVal = [true, false, true];
  List<String> reminderText = ['Walking', 'Prepare meal', 'Playing'];
  List<String> reminderTime = ['8:00am', '11:00am', '5:00pm'];

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
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        // backgroundColor: colorScheme.secondary,
        appBar: AppBar(
          backgroundColor: colorScheme.primary,
          // title: Text('Pet Records      '),
          // automaticallyImplyLeading: true,
          title: TabBar(
            indicatorColor: Colors.white,
            tabs: [
              Tab(text: 'Lucas'),
              Tab(text: 'Kitty'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Center(child: buildPetPage('Lucas', context)),
            Center(child: buildPetPage('Kitty', context)),
          ],
        ),
      ),
    );
  }

  Widget buildPetPage(String petName, BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        // backgroundColor: colorScheme.secondary,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          // shadowColor: Colors.grey,
          // title: Text('Pet Records      '),
          // automaticallyImplyLeading: true,
          title: TabBar(
            indicatorColor: Colors.grey,
            tabs: [
              Tab(text: 'Record'),
              Tab(text: 'Reminder'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Center(child: buildRecordList(petName)),
            Center(child: buildReminderList(petName)),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: colorScheme.primary,
          foregroundColor: Colors.black,
          onPressed: () {
            setState(() {
              _addRecord(context);
            });
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }

  _addRecord(BuildContext parentContext) async {
    return showDialog<Null>(
      context: parentContext,
      barrierDismissible: false,

      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Create a new record'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextFormField(
                initialValue: '04/27/2021',
                maxLength: 20,
                decoration: InputDecoration(
                  icon: Icon(Icons.favorite),
                  labelText: 'Date',
                ),
              ),
              TextFormField(
                initialValue: '10',
                maxLength: 4,
                decoration: InputDecoration(
                  icon: Icon(Icons.favorite),
                  labelText: 'Weight',
                ),
              ),
              TextFormField(
                initialValue: '200',
                maxLength: 4,
                decoration: InputDecoration(
                  icon: Icon(Icons.favorite),
                  labelText: 'Calories',
                ),
              ),
            ],
          ),
          actions: [
            FlatButton(
              textColor: shrinePink400,
              onPressed: () => Navigator.pop(context),
              child: Text('Confirm'),
            ),
            FlatButton(
              textColor: shrinePink400,
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel'),
            ),
          ],
        );
      }
    );
  }

  Widget buildRecordList(String tab) {
    return ListView(
      children: [
        buildRecord('04/13/2021'),
        buildRecord('04/14/2021'),
      ],
    );
  }


  Widget buildRecord(String tab) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          ListTile(
            // leading: Text("04/13/2021"),
            title: Center(child: Text(tab, style: TextStyle(fontSize: 25))),
          ),
          Image.network('https://www.ctvnews.ca/polopoly_fs/1.5098407.1599687805!/httpImage/image.jpg_gen/derivatives/landscape_1020/image.jpg'),
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
          ButtonBar(
            alignment: MainAxisAlignment.start,
          ),
        ],
      ),
    );
  }

  Widget buildReminderList(String tab) {
    int count = 3;
    return Scaffold(
      body: Column(
        children: <Widget>[
          for (int i = 0; i < count; i++)
            ListTile(
              title: Text('${reminderText[i]}'),
              leading: Switch(
                value: reminderVal[i],
                onChanged: i == count ? null
                      : (bool value) {
                  setState(() {
                    reminderVal[i] = value;
                  });
                },
              ),
              trailing: Text('${reminderTime[i]}'),
            ),
        ],
      ),
    );
  }

}

const Color shrinePink400 = Color(0xFFEAA4A4);