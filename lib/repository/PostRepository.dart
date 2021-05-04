import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:petopia/models/Post.dart';

class PostRepository {
  final CollectionReference collection = Firestore.instance.collection('posts');

  Stream<QuerySnapshot> getStream() {
    return collection.snapshots();
  }

  Future<DocumentReference> addPost(Post post) {
    return collection.add(post.toJson());
  }

  updatePost(Post post) async {
    await collection.document(post.reference.documentID).updateData(post.toJson());
  }
}
