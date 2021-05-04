import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:petopia/models/User.dart';

class UserRepository {
  final CollectionReference collection = Firestore.instance.collection('users');

  Stream<QuerySnapshot> getStream() {
    return collection.snapshots();
  }

  Future<DocumentReference> addUser(User user) {
    return collection.add(user.toJson());
  }

  updateUser(User user) async {
    await collection.document(user.reference.documentID).updateData(user.toJson());
  }
}
