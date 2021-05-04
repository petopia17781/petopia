import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class Post {
  final String description;
  final String mediaUrl;
  final String uid;
  String username;
  final DateTime timestamp;
  String location;
  List<String> likedBy;
  DocumentReference reference;

  Post({
    @required this.description,
    @required this.mediaUrl,
    @required this.uid,
    this.username,
    @required this.timestamp,
    this.location,
  });

  factory Post.fromSnapshot(DocumentSnapshot snapshot) {
    Post post = Post.fromJson(snapshot.data);
    post.reference = snapshot.reference;
    return post;
  }

  factory Post.fromJson(Map<String, dynamic> json) => _postFromJson(json);

  Map<String, dynamic> toJson() => _postToJson(this);

  @override
  String toString() => "Post<$reference>";
}

Post _postFromJson(Map<String, dynamic> json)  {
  return Post(
      description: json['description'] as String,
      uid: json['uid'] as String,
      mediaUrl: json['mediaUrl'] as String,
      location: json['location'] as String,
      timestamp: (json['timestamp'] as Timestamp).toDate(),
  );
}

Map<String, dynamic> _postToJson(Post instance) => <String, dynamic> {
  'description': instance.description,
  'mediaUrl': instance.mediaUrl,
  'uid': instance.uid,
  'timestamp': instance.timestamp,
  'location' : instance.location,
};
