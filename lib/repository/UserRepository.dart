import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:petopia/models/User.dart';

class UserDataRepository {

  final String uid;
  UserDataRepository({this.uid});

  final CollectionReference collection = Firestore.instance.collection('userData');
  
  Stream<UserData> getUserData() {
    return collection.document(uid).snapshots()
        .map((snapshot) => UserData.fromSnapshot(snapshot));
  }

  Future addUserData(UserData userData) async {
    return await collection.document(uid).setData(userData.toJson());
  }

  updateUserData(UserData userData) async {
    await collection.document(uid).updateData(userData.toJson());
  }
}
