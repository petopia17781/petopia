import 'package:flutter/material.dart';
import 'package:petopia/repository/PetRepository.dart';

import 'models/Pet.dart';

class MyPetPage extends StatefulWidget {

  MyPetPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyPetPageState createState() => _MyPetPageState();
}

class _MyPetPageState extends State<MyPetPage> {
  final PetRepository repository = PetRepository();
  // network pics
  List<String> picLinks = [
    'https://firebasestorage.googleapis.com/v0/b/flutter-test-56215.appspot.com/o/Calories.png?alt=media&token=74247fd8-b91c-4655-ac74-7df6371b2787',
    'https://firebasestorage.googleapis.com/v0/b/flutter-test-56215.appspot.com/o/Calories.png?alt=media&token=74247fd8-b91c-4655-ac74-7df6371b2787'
  ];
  // for reminder
  List<bool> reminderVal = [true, false, true];
  List<String> reminderText = ['Walking', 'Prepare meal', 'Playing'];
  List<String> reminderTime = ['8:00am', '11:00am', '5:00pm'];
  // for recording
  List<String> recordDates = ['04/27/2021','04/26/2021','04/25/2021'];

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
    repository.addPet(Pet(_counter.toString(), "pet1", type:"cat"));
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
      child: Builder(builder: (BuildContext tabContext) {
        return Scaffold(
          // backgroundColor: colorScheme.secondary,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
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
                if (DefaultTabController.of(tabContext).index == 0) {
                  _addRecord(context);
                } else {
                  _addReminder(context);
                }
              });
            },
            child: Icon(Icons.add),
          ),
        );
      },)
      ,
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
                initialValue: '04/28/2021',
                maxLength: 20,
                decoration: InputDecoration(
                  icon: Icon(Icons.favorite),
                  labelText: 'Date',
                ),
              ),
              TextFormField(
                initialValue: '9.49lbs',
                maxLength: 10,
                decoration: InputDecoration(
                  icon: Icon(Icons.favorite),
                  labelText: 'Weight',
                ),
              ),
              TextFormField(
                initialValue: '97cal',
                maxLength: 10,
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
              onPressed: () {
                setState(() {
                  recordDates.insert(0, '04/28/2021');
                });
                Navigator.pop(context);
              },
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

  _addReminder(BuildContext parentContext) async {
    return showDialog<Null>(
        context: parentContext,
        barrierDismissible: false,

        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Create a new reminder'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextFormField(
                  initialValue: 'Sleeping',
                  maxLength: 20,
                  decoration: InputDecoration(
                    icon: Icon(Icons.favorite),
                    labelText: 'Reminder',
                  ),
                ),
                TextFormField(
                  initialValue: '10:00pm',
                  maxLength: 10,
                  decoration: InputDecoration(
                    icon: Icon(Icons.favorite),
                    labelText: 'Time',
                  ),
                ),
              ],
            ),
            actions: [
              FlatButton(
                textColor: shrinePink400,
                onPressed: () {
                  setState(() {
                    reminderVal.add(true);
                    reminderTime.add("10:00pm");
                    reminderText.add("Sleeping");
                  });
                  Navigator.pop(context);
                },
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

  Widget buildRecordList(String petName) {
    return ListView(
      children: [
        for (int i = 0; i < recordDates.length; i++)
          buildRecord(recordDates[i], petName)
      ],
    );
  }

  Widget buildRecord(String date, String petName) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          ListTile(
            // leading: Text("04/13/2021"),
            title: Center(child: Text(date, style: TextStyle(fontSize: 25))),
          ),
          Image.network((petName.startsWith('Lucas') ? picLinks[0] : picLinks[1])),
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
            title: Text('Deworming'),
            leading: Icon(Icons.pan_tool),
            trailing: Text('05/24/2021'),
          ),
          ListTile(
            title: Text('Vaccination'),
            leading: Icon(Icons.verified_user),
            trailing: Text('11/18/2021'),
          ),
          ButtonBar(
            alignment: MainAxisAlignment.start,
          ),
        ],
      ),
    );
  }

  Widget buildReminderList(String tab) {
    int count = reminderText.length;
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