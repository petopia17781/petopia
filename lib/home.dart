import 'dart:collection';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker_modern/image_picker_modern.dart';
import 'package:petopia/createposts.dart';
import 'package:flutter/material.dart';
import 'package:petopia/SizeConfig.dart';

import 'models/Post.dart';


final postCollection = Firestore.instance.collection("posts");

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin<HomePage>{
  Container loadingPlaceHolder = Container(
    height: 500.0,
    child: Center(child: CircularProgressIndicator()),
  );
  File file;
  Future<QuerySnapshot> posts;

  @override
  void initState() {
    loadPosts();
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
        crossAxisSpacing: 3 * SizeConfig.widthMultiplier,
        mainAxisSpacing: 1 * SizeConfig.heightMultiplier,
        itemCount: postModels.length,
        itemBuilder: (context, index) {
          return PostCard(post: postModels[index]);
        },
        staggeredTileBuilder: (index) {
          return StaggeredTile.count(1, 1.1);
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
      return Scaffold(
        appBar: AppBar(
          leading: Icon(Icons.menu),
          title: Center(child: Text("Petopia")),
          actions: [
            Icon(Icons.search),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Icon(Icons.mail),
            ),
          ],
          backgroundColor: colorScheme.primary,
        ),
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

class PostCard extends StatelessWidget {
  const PostCard({
    Key key,
    this.width = 140,
    this.aspectRetio = 1.02,
    @required this.post,
  }) : super(key: key);

  final double width, aspectRetio;
  final Post post;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 2 * SizeConfig.widthMultiplier),
      child: SizedBox(
        width: 30 * SizeConfig.widthMultiplier,
        child: GestureDetector(
          onTap: () {},
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(0 * SizeConfig.widthMultiplier),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // picture
                    Hero(
                      tag: post.postId,
                      child: AspectRatio(
                          aspectRatio: 1.3,
                          child: Image.network(post.mediaUrl)
                      ),
                    ),
                    Container(

                      padding: EdgeInsets.symmetric(horizontal: 3 * SizeConfig.widthMultiplier),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            post.description,
                            style: TextStyle(color: Colors.black),
                            maxLines: 2,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                post.username,
                                style: TextStyle(
                                  fontSize: 1.5 * SizeConfig.textMultiplier,
                                  fontWeight: FontWeight.w600,
                                  color: colorScheme.primary,
                                ),
                              ),
                              InkWell(
                                borderRadius: BorderRadius.circular(50),
                                onTap: () {},
                                child: Container(
                                  padding: EdgeInsets.all(0.5 * SizeConfig.widthMultiplier),
                                  height: 5 * SizeConfig.heightMultiplier,
                                  width: 5 * SizeConfig.widthMultiplier,
                                  decoration: BoxDecoration(
                                    color: post.isLike
                                        ? colorScheme.primary.withOpacity(0.15)
                                        : colorScheme.secondary.withOpacity(0.1),
                                    shape: BoxShape.circle,
                                  ),
                                  child: SvgPicture.asset(
                                    "assets/icons/Heart Icon_2.svg",
                                    color: post.isLike
                                        ? Colors.red
                                        : Colors.grey.withOpacity(0.5),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),

                  ],
                ),
              ),
              const SizedBox(height: 10),


            ],
          ),
        ),
      ),
    );
  }
}