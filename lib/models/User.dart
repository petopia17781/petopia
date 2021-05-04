import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:petopia/models/Post.dart';
import 'package:petopia/models/Pet.dart';

class User {
  final String uid;

  User({ this.uid });
}

class UserData {
  final String uid;
  final String username;
  final String description;
  final String avatarUrl;

   List<Pet> pets;
   List<Post> posts;

  DocumentReference reference;

  UserData({
    @required this.uid,
    @required this.username,
    @required this.description,
    @required this.avatarUrl,
    this.pets,
    this.posts
  });

  factory UserData.fromSnapshot(DocumentSnapshot snapshot) {
    UserData userData = UserData.fromJson(snapshot.data);
    userData.reference = snapshot.reference;
    return userData;
  }

  factory UserData.fromJson(Map<String, dynamic> json) => _userDataFromJson(json);

  Map<String, dynamic> toJson() => _userDataToJson(this);

  @override
  String toString() => "UserData<$uid,$username>";
}

/// from/to Json
UserData _userDataFromJson(Map<String, dynamic> json) {
  return UserData(
      uid: json['uid'] as String,
      username: json['username'] as String,
      description: json['description'] as String,
      avatarUrl: json['avatarUrl'] as String,
      pets: _convertPets(json['pets'] as List),
      posts: _convertPosts(json['posts'] as List)
  );
}

Map<String, dynamic> _userDataToJson(UserData instance) => <String, dynamic> {
  'uid': instance.uid,
  'username': instance.username,
  'description': instance.description,
  'avatarUrl': instance.avatarUrl,
  'pets': _petList(instance.pets),
  'posts': _postList(instance.posts),
};

/// handle pet list and post list
List<Pet> _convertPets(List petMap) {
  if (petMap == null) {
    return null;
  }
  List<Pet> pets =  List<Pet>();
  petMap.forEach((value) {
    petMap.add(Pet.fromJson(value));
  });
  return pets;
}

List<Post> _convertPosts(List postMap) {
  if (postMap == null) {
    return null;
  }
  List<Post> posts =  List<Post>();
  postMap.forEach((value) {
    postMap.add(Post.fromJson(value));
  });
  return posts;
}

List<Map<String, dynamic>> _petList(List<Pet> pets) {
  if (pets == null) {
    return null;
  }
  List<Map<String, dynamic>> petMap =List<Map<String, dynamic>>();
  pets.forEach((pet) {
    petMap.add(pet.toJson());
  });
  return petMap;
}

List<Map<String, dynamic>> _postList(List<Post> posts) {
  if (posts == null) {
    return null;
  }
  List<Map<String, dynamic>> postMap =List<Map<String, dynamic>>();
  posts.forEach((post) {
    postMap.add(post.toJson());
  });
  return postMap;
}
