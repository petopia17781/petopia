import 'package:flutter/material.dart';
import 'package:petopia/SizeConfig.dart';

class ProfilePage extends StatefulWidget {

  ProfilePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {


  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      body: Stack(
        children: <Widget>[
          // header
          Container(
            color: shrinePink400,
            height: 30 * SizeConfig.heightMultiplier,
            child: Padding(
              padding: EdgeInsets.only(left: 30.0, right: 30.0, top: 5 * SizeConfig.heightMultiplier),
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
                            image: NetworkImage("https://www.carnegiecouncil.org/people/andrew-carnegie/_res/id=Picture/thumbnail=1/width=170/quality=100")
                          )
                        ),
                      ),
                      SizedBox(width: 5 * SizeConfig.widthMultiplier,),
                      // User name
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("Andrew Carnegie", style: TextStyle(
                            color: Colors.black38,
                            fontSize: 3 * SizeConfig.textMultiplier,
                            fontWeight: FontWeight.bold
                          ),),
                          SizedBox(height: 1 * SizeConfig.heightMultiplier,),
                          Row(
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Image.asset("assets/instagram.png",
                                  height: 3 * SizeConfig.heightMultiplier,
                                  width: 3 * SizeConfig.widthMultiplier,),
                                  SizedBox(width: 2 * SizeConfig.widthMultiplier,),
                                  Text("Carnegie", style: TextStyle(
                                      color: Colors.black26,
                                      fontSize: 1.5 * SizeConfig.textMultiplier,
                                  ),),
                                ],
                              )
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                  SizedBox(height: 3 * SizeConfig.heightMultiplier,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        children: [
                          Text("15.3K", style: TextStyle(
                              color: Colors.black38,
                              fontSize: 3 * SizeConfig.textMultiplier,
                              fontWeight: FontWeight.bold
                          ),),
                          Text("Followers", style: TextStyle(
                            color: Colors.black26,
                            fontSize: 1.9 * SizeConfig.textMultiplier,
                          ),),
                        ],
                      ),
                      Column(
                        children: [
                          Text("314", style: TextStyle(
                              color: Colors.black38,
                              fontSize: 3 * SizeConfig.textMultiplier,
                              fontWeight: FontWeight.bold
                          ),),
                          Text("Following", style: TextStyle(
                            color: Colors.black26,
                            fontSize: 1.9 * SizeConfig.textMultiplier,
                          ),),
                        ],
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black26),
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("EDIT PROFILE", style: TextStyle(
                              color: Colors.black26,
                              fontSize: 1.8 * SizeConfig.textMultiplier
                          ),),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
          // tab
          Padding(
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
          )
        ],
      ),
    );
  }

}

const Color shrinePink400 = Color(0xFFEAA4A4);