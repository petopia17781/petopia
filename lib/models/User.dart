import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:petopia/models/Post.dart';
import 'package:petopia/models/Pet.dart';

class User {
  final String userId;
  String name;
  String notes;

  List<Pet> pets;
  List<Post> posts;

  DocumentReference reference;

  User(this.userId, this.name, {this.notes, this.pets, this.posts, this.reference});

  factory User.fromSnapshot(DocumentSnapshot snapshot) {
    User newUser = User.fromJson(snapshot.data);
    newUser.reference = snapshot.reference;
    return newUser;
  }

  factory User.fromJson(Map<String, dynamic> json) => _UserFromJson(json);

  Map<String, dynamic> toJson() => _UserToJson(this);
  @override
  String toString() => "User<$name>";
}

/// from/to Json
User _UserFromJson(Map<String, dynamic> json) {
  return User(
      json['userId'] as String,
      json['name'] as String,
      notes: json['notes'] as String,
      pets: _convertPets(json['pets'] as List),
      posts: _convertPosts(json['posts'] as List)
  );
}

Map<String, dynamic> _UserToJson(User instance) => <String, dynamic> {
  'userId': instance.userId,
  'name': instance.name,
  'notes': instance.notes,
  'pets': _PetList(instance.pets),
  'posts': _PostList(instance.posts),
};

/// handle pet list and post list
List<Pet> _convertPets(List petMap) {
  if (petMap == null) {
    return null;
  }
  List<Pet> pets =  List<Pet>();
  petMap.forEach((value) {
    petMap.add(Pet.fromJson(value));
  });
  return pets;
}

List<Post> _convertPosts(List postMap) {
  if (postMap == null) {
    return null;
  }
  List<Post> posts =  List<Post>();
  postMap.forEach((value) {
    postMap.add(Post.fromJson(value));
  });
  return posts;
}

List<Map<String, dynamic>> _PetList(List<Pet> pets) {
  if (pets == null) {
    return null;
  }
  List<Map<String, dynamic>> petMap =List<Map<String, dynamic>>();
  pets.forEach((pet) {
    petMap.add(pet.toJson());
  });
  return petMap;
}

List<Map<String, dynamic>> _PostList(List<Post> posts) {
  if (posts == null) {
    return null;
  }
  List<Map<String, dynamic>> postMap =List<Map<String, dynamic>>();
  posts.forEach((post) {
    postMap.add(post.toJson());
  });
  return postMap;
}
