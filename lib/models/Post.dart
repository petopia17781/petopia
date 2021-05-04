import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class Post {
  final String description;
  final String mediaUrl;
  final String userId;
  final String username;
  final DateTime timestamp;
  String location;
  List<String> likedBy;
  DocumentReference reference;

  Post({
    @required this.description,
    @required this.mediaUrl,
    @required this.userId,
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

// 1
Post _postFromJson(Map<String, dynamic> json)  {
  return Post(
      description: json['description'] as String,
      userId: json['userId'] as String,
      mediaUrl: json['mediaUrl'] as String,
      username: json['username'] as String,
      location: json['location'] as String,
      timestamp: (json['timestamp'] as Timestamp).toDate(),
  );
}
Map<String, dynamic> _postToJson(Post instance) => <String, dynamic> {
  'description': instance.description,
  'mediaUrl': instance.mediaUrl,
  'userId': instance.userId,
  'username': instance.username,
  'timestamp': instance.timestamp,
  'location' : instance.location,
};
