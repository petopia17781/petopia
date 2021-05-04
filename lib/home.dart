import 'dart:collection';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:image_picker_modern/image_picker_modern.dart';
import 'package:petopia/createposts.dart';
import 'package:petopia/mypet.dart';
import 'package:petopia/nearby.dart';
import 'package:flutter/material.dart';
import 'package:petopia/profileWrapper.dart';
import 'package:petopia/services/auth.dart';
import 'package:petopia/store.dart';
import 'package:provider/provider.dart';

import 'models/Post.dart';
import 'models/User.dart';


final postCollection = Firestore.instance.collection("posts");
class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static List<Widget> _widgetOptions = <Widget>[
    MyHomeWidget(),
    StorePage(title: "Store"),
    MyPetPage(title: "My Pet"),
    NearbyPage(title: "Nearby"),
    StreamProvider<User>.value(
        value: AuthService().user,
        child: ProfileWrapper()
    )
  ];

  Widget getAppBar(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    return AppBar(
      leading: Icon(Icons.menu),
      title: Center(child: Text("Petopia")),
      actions: [
        Icon(Icons.favorite),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Icon(Icons.search),
        ),
        Icon(Icons.more_vert),
      ],
      backgroundColor: colorScheme.primary,
    );
  }


  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
        appBar: getAppBar(context),
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

class MyHomeWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyHomeWidgetState();
  }
}

class _MyHomeWidgetState extends State<MyHomeWidget> with AutomaticKeepAliveClientMixin<MyHomeWidget>{
  Container loadingPlaceHolder = Container(
    height: 500.0,
    child: Center(child: CircularProgressIndicator()),
  );
  String imageUrl = "https://images.indianexpress.com/2019/04/cat_759getty.jpg";
  Map likes = new HashMap();
  bool liked = false;
  File file;
  Future<QuerySnapshot> posts;

  @override
  void initState() {
    loadPosts();
  }


  GetPostHeader({String ownerId}) {
    if (ownerId == null) {
      return Text("owner error");
    }

    return ListTile(
      leading: CircleAvatar(
        backgroundImage: CachedNetworkImageProvider(imageUrl),
        backgroundColor: Colors.grey,
      ),
      title: GestureDetector(
        child: Text("My test"),
        onTap: () {
          // openProfile(context, ownerId);
        },
      ),
      subtitle: Text("yihua test"),
      trailing: const Icon(Icons.more_vert),
    );
  }

  bool showHeart = false;
  GestureDetector GetImage(String img) {
    return GestureDetector(
      // onDoubleTap: () => _likePost(postId),
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          CachedNetworkImage(
            imageUrl: img,
            fit: BoxFit.fill,
            height: 150,
            placeholder: (context, url) => loadingPlaceHolder,
            errorWidget: (context, url, error) => Icon(Icons.error),
          ),
          showHeart
              ? Positioned(
                  child: Container(
                    // width: 100,
                    // height: 100,
                    child: Opacity(
                        opacity: 0.85,
                        child: FlareActor(
                          "assets/flare/Like.flr",
                          animation: "Like",
                        )),
                  ),
                )
              : Container()
        ],
      ),
    );
  }

  GestureDetector GetLikeIcon() {
    Color color;
    IconData icon;

    if (liked) {
      color = Colors.pink;
      icon = Icons.favorite;
    } else {
      icon = Icons.favorite_border;
    }

    return GestureDetector(
        child: Icon(
          icon,
          size: 24.0,
          color: color,
        ),
        onTap: () {
          setState(() {
            liked = !liked;
          });
        });
  }

  String GetTime(DateTime t) {
    if (t != null) {
      return t.year.toString() + "-" + t.month.toString() + "-" + t.day.toString();
    }
    return "";
  }
  Widget postLists(Post post) {
    return Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            GetImage(post.mediaUrl),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(padding: const EdgeInsets.only(left: 20.0)),
                Text(post.description),
                // Padding(padding: const EdgeInsets.only(right: 20.0)),
                // GestureDetector(
                //   child: const Icon(
                //     Icons.comment,
                //     size: 25.0,
                //   ),
                //   // onTap: () {
                //   //   goToComments(
                //   //       context: context,
                //   //       postId: postId,
                //   //       ownerId: ownerId,
                //   //       mediaUrl: mediaUrl);
                //   // }
                // ),
              ],
            ),
            Row(
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(left: 20.0),
                  child: Text(
                    post.username,

                  ),
                )
              ],
            ),
            Row(
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(left: 20.0),
                  child: Text(
                    GetTime(post.timestamp)
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(padding: const EdgeInsets.only(left: 150.0, top: 10)),
                GetLikeIcon(),
              ],
            )
          ],
        ));
  }

  StaggeredGridView BuildPostResults(List<DocumentSnapshot> docs) {
    List<Post> postModels = [];

    docs.forEach((DocumentSnapshot doc) {
      Post post = Post.fromSnapshot(doc);
      postModels.add(post);
    });

    return getImageGrid(postModels);
  }

  Widget getImageGrid(postModels) {
    return StaggeredGridView.countBuilder(
        crossAxisCount: 2,
        crossAxisSpacing: 20,
        mainAxisSpacing: 15,
        itemCount: postModels.length,
        itemBuilder: (context, index) {
          return postLists(postModels[index]);
        },
        staggeredTileBuilder: (index) {
          return StaggeredTile.count(1, 1.2);
        });
  }

  void loadPosts() async {
    Future<QuerySnapshot> ps = postCollection.orderBy("timestamp", descending: true).getDocuments();

    setState(() {
      posts = ps;
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    if (file != null) {
      return CreatePostPage(file: file);
    } else {
      return SafeArea(
        child: Scaffold(
          backgroundColor: colorScheme.secondary,
          body: Container(
            margin: EdgeInsets.all(10),
            child: FutureBuilder<QuerySnapshot>(
                future: posts,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return BuildPostResults(snapshot.data.documents);
                  } else {
                    return Container(
                        alignment: FractionalOffset.center,
                        child: CircularProgressIndicator());
                  }
                }),
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: colorScheme.primary,
            foregroundColor: Colors.black,
            onPressed: () {
              setState(() {
                _selectImage(context);
              });
            },
            child: Icon(Icons.add),
          ),
        ),
      );
  }}


  _selectImage(BuildContext parentContext) async {
    return showDialog<Null>(
      context: parentContext,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return SimpleDialog(
          title: const Text('Create a Post'),
          children: <Widget>[
            SimpleDialogOption(
                child: const Text('Take a photo'),
                onPressed: () async {
                  Navigator.pop(context);
                  var imageFile = await ImagePicker.pickImage(
                      source: ImageSource.camera,
                      maxWidth: 1920,
                      maxHeight: 1200);
                  // await imagePicker.getImage(source: ImageSource.camera, maxWidth: 1920, maxHeight: 1200, imageQuality: 80);
                  if (imageFile != null) {
                    setState(() {
                      file = imageFile.absolute;
                    });
                  }
                }),
            SimpleDialogOption(
                child: const Text('Choose from Gallery'),
                onPressed: () async {
                  Navigator.of(context).pop();
                  var imageFile = await ImagePicker.pickImage(
                      source: ImageSource.gallery,
                      maxWidth: 1920,
                      maxHeight: 1200);
                  if (imageFile != null) {
                    setState(() {
                      file = imageFile.absolute;
                    });
                  }

                }),
            SimpleDialogOption(
              child: const Text("Cancel"),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
