import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class Post {
  String description;
  String mediaUrl;
  String userId;
  String postId;
  String username;
  DocumentReference reference;
  DateTime timestamp;
  Post(this.postId, {this.description, this.mediaUrl, this.userId, this.reference, this.username, this.timestamp});
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
      userId: json['userId'] as String,
      mediaUrl: json['mediaUrl'] as String,
      username: json['username'] as String,
      timestamp: json['date'] == null ? null : (json['date'] as Timestamp).toDate() as DateTime,
  );
}
Map<String, dynamic> _PostToJson(Post instance) => <String, dynamic> {
  'description': instance.description,
  'mediaUrl': instance.mediaUrl,
  'userId': instance.userId,
  'postId': instance.postId,
  'username': instance.username,
  'timestamp': instance.timestamp
};
