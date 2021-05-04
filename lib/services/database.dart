import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {

  final String userId;
  DatabaseService({this.userId});

  // collection reference
  final CollectionReference userProfileCollection = Firestore.instance.collection('userProfile');

  Future updateUserProfile(String username, String description, String avatarUrl) async {
    return await userProfileCollection.document(userId).setData({
      'username': username,
      'description': description,
      'avatarUrl': avatarUrl
    });
  }

}