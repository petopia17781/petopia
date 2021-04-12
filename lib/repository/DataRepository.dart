import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:petopia/models/Pet.dart';

class DataRepository {
  // 1
  final CollectionReference collection = Firestore.instance.collection('pets');
  // 2
  Stream<QuerySnapshot> getStream() {
    return collection.snapshots();
  }
  // 3
  Future<DocumentReference> addPet(Pet pet) {
    return collection.add(pet.toJson());
  }
  // 4
  updatePet(Pet pet) async {
    await collection.document(pet.reference.documentID).updateData(pet.toJson());
  }

  Future<DocumentReference> getPetDocumentRef(String petName) async {
    await collection.where("name", isEqualTo: petName).getDocuments();
  }
}
