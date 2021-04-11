import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker_modern/image_picker_modern.dart';
import 'package:petopia/home.dart';
import 'package:uuid/uuid.dart';

class CreatePostPage extends StatefulWidget {
  CreatePostPage({Key key, this.title, this.file}) : super(key: key);
  final String title;
  final File file;
  @override
  _CreatePostPageState createState() {
    print(file);
    return _CreatePostPageState(file);
  }
}

class _CreatePostPageState extends State<CreatePostPage> {
  File file;


  Map<String, double> currentLocation = Map();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  ImagePicker imagePicker = ImagePicker();

  bool uploading = false;

  _CreatePostPageState(File file) {
    this.file = file;
  }

  @override
  initState() {
    //variables with location assigned as 0.0
    currentLocation['latitude'] = 0.0;
    currentLocation['longitude'] = 0.0;
    // initPlatformState(); //method to call location
    super.initState();
  }

  // //method to get Location and save into variables
  // initPlatformState() async {
  //   Address first = await getUserLocation();
  //   setState(() {
  //     address = first;
  //   });
  // }

  Widget build(BuildContext context) {
    return file == null
        ? MyHomeWidget(): Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              backgroundColor: Colors.white70,
              leading: IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.black),
                  onPressed: clearImage),
              title: const Text(
                'Post to',
                style: const TextStyle(color: Colors.black),
              ),
              actions: <Widget>[
                FlatButton(
                    onPressed: postImage,
                    child: Text(
                      "Post",
                      style: TextStyle(
                          color: Colors.blueAccent,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0),
                    ))
              ],
            ),
            body: ListView(
              children: <Widget>[
                PostForm(
                  imageFile: file,
                  descriptionController: descriptionController,
                  locationController: locationController,
                  loading: uploading,
                ),
                Divider(), //scroll view where we will show location to users
              ],
            ));
  }

  //method to build buttons with location.
  buildLocationButton(String locationName) {
    if (locationName != null ?? locationName.isNotEmpty) {
      return InkWell(
        onTap: () {
          locationController.text = locationName;
        },
        child: Center(
          child: Container(
            //width: 100.0,
            height: 30.0,
            padding: EdgeInsets.only(left: 8.0, right: 8.0),
            margin: EdgeInsets.only(right: 3.0, left: 3.0),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: Center(
              child: Text(
                locationName,
                style: TextStyle(color: Colors.grey),
              ),
            ),
          ),
        ),
      );
    } else {
      return Container();
    }
  }

  void clearImage() {
    setState(() {
      file = null;
    });
  }

  void postImage() {
    setState(() {
      uploading = true;
    });

    print("postToFireStore");
    uploadImage(file).then((String data) {
      postToFireStore(
          mediaUrl: data,
          description: descriptionController.text,
          location: locationController.text);
    }).then((_) {
      setState(() {
        file = null;
        uploading = false;
      });
    });
  }
}

class PostForm extends StatelessWidget {
  final imageFile;
  final TextEditingController descriptionController;
  final TextEditingController locationController;
  final bool loading;
  PostForm(
      {this.imageFile,
      this.descriptionController,
      this.loading,
      this.locationController});
  String imageUrl = "https://images.indianexpress.com/2019/04/cat_759getty.jpg";
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        loading
            ? LinearProgressIndicator()
            : Padding(padding: EdgeInsets.only(top: 0.0)),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
        children:<Widget>[CircleAvatar(backgroundImage: NetworkImage(imageUrl)
          // backgroundImage: NetworkImage(currentUserModel.photoUrl),
          )]),
        Row(

          children: <Widget>[
            Container(
              width: 250.0,
              height: 100,
              child: TextField(
                controller: descriptionController,
                decoration: InputDecoration(
                    hintText: "Write a caption...", border: InputBorder.none),
              ),
            ),
          ],

        ),
        Row (
          children: <Widget>[
            Container(
              height: 300.0,
              width: 300.0,
              child: AspectRatio(
                aspectRatio: 487 / 451,
                child: Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        alignment: FractionalOffset.topCenter,
                        image: FileImage(imageFile),
                      )),
                ),
              ),
            )
          ],
        )]);
    //     ListTile(
    //       leading: Icon(Icons.pin_drop),
    //       title: Container(
    //         width: 250.0,
    //         child: TextField(
    //           controller: locationController,
    //           decoration: InputDecoration(
    //               hintText: "Where was this photo taken?",
    //               border: InputBorder.none),
    //         ),
    //       ),
    //     )
    //   ],
    // );
  }
}

Future<String> uploadImage(var imageFile) async {
  var uuid = Uuid().v1();
  StorageReference ref = FirebaseStorage.instance.ref().child("post_$uuid.jpg");
  StorageUploadTask uploadTask = ref.putFile(imageFile);
  StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
  taskSnapshot.ref.getDownloadURL().then(
        (value) => print("Done: $value"),
  );
  return ref.getPath();
}

void postToFireStore(
    {String mediaUrl, String location, String description}) async {
  var reference = Firestore.instance.collection('posts');
  reference.add({
    //"username": "currentUserModel.username",
    "username": "yihuatest",
    // "location": location,
    // "likes": {},
    "mediaUrl": mediaUrl,
    "description": description,
    "ownerId": 123456,
    // "ownerId": googleSignIn.currentUser.id,
    "timestamp": DateTime.now(),
  }).then((DocumentReference doc) {
    String docId = doc.documentID;
    reference.document(docId).updateData({"postId": docId});
  });
}

const Color shrinePink400 = Color(0xFFEAA4A4);
