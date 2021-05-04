import 'package:firebase_auth/firebase_auth.dart';
import 'package:petopia/models/User.dart';
import 'package:petopia/repository/UserRepository.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create user object based on FirebaseUser
  User _userFromFirebaseUser(FirebaseUser user) {
    if (user == null) {
      return null;
    }
    if (user.isAnonymous) {
      return User(uid: user.uid);
    }
    return User(uid: user.uid);
  }

  // auth change user stream
  Stream<User> get user {
    return _auth.onAuthStateChanged
        .map(_userFromFirebaseUser);
  }

  // sign in anonymously
  Future signInAnon() async {
    try {
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // sign in with email & password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email,
          password: password
      );
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // sign up with email & password
  Future signUpWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password
      );
      FirebaseUser user = result.user;
      // create a new document for the user with the uid
      await UserDataRepository(uid: user.uid).addUserData(
        UserData(
          uid: user.uid,
          username: 'Meow Petopia',
          description: 'Nothing here meow',
          avatarUrl: 'https://images-na.ssl-images-amazon.com/images/I/31Rgh5fBqDL.jpg',
        )
      );
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}