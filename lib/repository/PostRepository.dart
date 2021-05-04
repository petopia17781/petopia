import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:petopia/models/Post.dart';

class PostRepository {
  final CollectionReference collection = Firestore.instance.collection('posts');

  List<Post> _postListFromSnapshot(QuerySnapshot snapshot) {
    List postList = snapshot.documents
        .map((doc) => Post.fromSnapshot(doc))
        .toList();
    postList.sort((a, b) {
      return b.timestamp.compareTo(a.timestamp);
    });
    return postList;
  }
  
  Stream<List<Post>> getPosts() {
    return collection.snapshots().map(_postListFromSnapshot);
  }

  Future<DocumentReference> addPost(Post post) {
    return collection.add(post.toJson());
  }

  updatePost(Post post) async {
    await collection.document(post.reference.documentID).updateData(post.toJson());
  }
}
