import 'dart:collection';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:image_picker_modern/image_picker_modern.dart';
import 'package:petopia/createposts.dart';
import 'package:petopia/mypet.dart';
import 'package:petopia/nearby.dart';
import 'package:petopia/profile.dart';
import 'package:flutter/material.dart';
import 'package:petopia/store.dart';



class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

enum MyChoice { AddTodo, AddWeight }

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  bool createPost = false;
  static List<Widget> _widgetOptions = <Widget>[
    MyHomeWidget(),
    StorePage(title: "Store"),
    MyPetPage(title: "My Pet"),
    NearbyPage(title: "Nearby"),
    ProfilePage(title: "My Profile"),
  ];


  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
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
      ),
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
      ),
    );
  }
}

class MyHomeWidget extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _MyHomeWidgetState();
  }
}


class _MyHomeWidgetState extends State<MyHomeWidget> {
  Container loadingPlaceHolder = Container(
    height: 500.0,
    child: Center(child: CircularProgressIndicator()),
  );
  String imageUrl = "https://images.indianexpress.com/2019/04/cat_759getty.jpg";
  Map likes = new HashMap();
  bool liked = false;
  File file;
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
              child:  Opacity(
                  opacity: 0.85,
                  child: FlareActor("assets/flare/Like.flr",
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

  Widget postLists(String img) {
    return Container(
        color: Colors.white,
        child:Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            GetImage(img),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(padding: const EdgeInsets.only(left: 20.0)),
                Text("Post Title"),
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
                    "username",
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                  Padding(padding: const EdgeInsets.only(left: 150.0, top:40)),
                  GetLikeIcon(),
              ],
            )
          ],
        )
    );
  }

  List<String> imageList = [
    'https://cdn.pixabay.com/photo/2020/12/15/16/25/clock-5834193__340.jpg',
    'https://cdn.pixabay.com/photo/2020/09/18/19/31/laptop-5582775_960_720.jpg',
    'https://media.istockphoto.com/photos/woman-kayaking-in-fjord-in-norway-picture-id1059380230?b=1&k=6&m=1059380230&s=170667a&w=0&h=kA_A_XrhZJjw2bo5jIJ7089-VktFK0h0I4OWDqaac0c=',
    'https://cdn.pixabay.com/photo/2019/11/05/00/53/cellular-4602489_960_720.jpg',
    'https://cdn.pixabay.com/photo/2017/02/12/10/29/christmas-2059698_960_720.jpg',
    'https://cdn.pixabay.com/photo/2020/01/29/17/09/snowboard-4803050_960_720.jpg',
    'https://cdn.pixabay.com/photo/2020/02/06/20/01/university-library-4825366_960_720.jpg',
    'https://cdn.pixabay.com/photo/2020/11/22/17/28/cat-5767334_960_720.jpg',
    'https://cdn.pixabay.com/photo/2020/12/13/16/22/snow-5828736_960_720.jpg',
    'https://cdn.pixabay.com/photo/2020/12/09/09/27/women-5816861_960_720.jpg',
  ];
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    if (file != null) {
      return CreatePostPage(file: file);
    } else
    return SafeArea(
      child: Scaffold(
        backgroundColor: colorScheme.secondary,
        body: Container(
          margin: EdgeInsets.all(10),
          child:  StaggeredGridView.countBuilder(
              crossAxisCount: 2,
              crossAxisSpacing: 20,
              mainAxisSpacing: 15,
              itemCount: imageList.length,
              itemBuilder: (context, index) {
                return postLists(imageList[index]);
              },
              staggeredTileBuilder: (index) {
                return StaggeredTile.count(1, 1.2);
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
  }


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
                  setState(() {
                    file = imageFile.absolute;
                  });
                }),
            SimpleDialogOption(
                child: const Text('Choose from Gallery'),
                onPressed: () async {
                  Navigator.of(context).pop();
                  var imageFile = await ImagePicker.pickImage(
                      source: ImageSource.gallery,
                      maxWidth: 1920,
                      maxHeight: 1200);
                  // var imageFile =
                  // await imagePicker.getImage(source: ImageSource.gallery, maxWidth: 1920, maxHeight: 1200, imageQuality: 80);
                  setState(() {
                    file = imageFile.absolute;
                  });
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
}
