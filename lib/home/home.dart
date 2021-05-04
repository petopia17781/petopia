import 'dart:io';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:image_picker_modern/image_picker_modern.dart';
import 'package:petopia/home/createposts.dart';
import 'package:flutter/material.dart';
import 'package:petopia/SizeConfig.dart';
import 'package:petopia/home/postCard.dart';
import 'package:petopia/models/Post.dart';
import 'package:petopia/repository/PostRepository.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin<HomePage>{
  File file;

  Widget getImageGrid(postList) {
    return StaggeredGridView.countBuilder(
        crossAxisCount: 2,
        crossAxisSpacing: 3 * SizeConfig.widthMultiplier,
        mainAxisSpacing: 1 * SizeConfig.heightMultiplier,
        itemCount: postList.length,
        itemBuilder: (context, index) {
          return PostCard(post: postList[index]);
        },
        staggeredTileBuilder: (index) {
          return StaggeredTile.count(1, 1.1);
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
          margin: EdgeInsets.all(2 * SizeConfig.widthMultiplier),
          child: StreamBuilder<List<Post>>(
              stream: PostRepository().getPosts(),
              builder: (context, snapshot) {
                List<Post> postList = snapshot.data;
                if (snapshot.hasData) {
                  return getImageGrid(postList);
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
