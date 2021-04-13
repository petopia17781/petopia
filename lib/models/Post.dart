import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class Post {
  String description;
  String mediaUrl;
  int ownerId;
  String postId;
  String username;
  DocumentReference reference;
  Post(this.postId, {this.description, this.mediaUrl, this.ownerId, this.reference, this.username});
  factory Post.fromSnapshot(DocumentSnapshot snapshot) {
    Post newPost = Post.fromJson(snapshot.data);
    newPost.reference = snapshot.reference;
    return newPost;
  }
  // 6
  factory Post.fromJson(Map<String, dynamic> json) => _PostFromJson(json);
  // 7
  Map<String, dynamic> toJson() => _PostToJson(this);
  @override
  String toString() => "Post<$postId>";
}

// 1
Post _PostFromJson(Map<String, dynamic> json)  {
  return Post(
      json['postId'] as String,
      description: json['description'] as String,
      ownerId: json['ownerId'] as int,
      mediaUrl: json['mediaUrl'] as String,
      username: json['username'] as String,
  );
}
Map<String, dynamic> _PostToJson(Post instance) => <String, dynamic> {
  'description': instance.description,
  'mediaUrl': instance.mediaUrl,
  'ownerId': instance.ownerId,
  'postId': instance.postId,
  'username': instance.username
};
