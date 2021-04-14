import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:petopia/models/Pet.dart';

class PetRepository {
  final CollectionReference collection = Firestore.instance.collection('pets');

  Stream<QuerySnapshot> getStream() {
    return collection.snapshots();
  }

  Future<DocumentReference> addPet(Pet pet) {
    return collection.add(pet.toJson());
  }

  updatePet(Pet pet) async {
    await collection.document(pet.reference.documentID).updateData(pet.toJson());
  }

  Future<QuerySnapshot> getPetDocumentRef(String petName) async {
    await collection.where("name", isEqualTo: petName).getDocuments();
  }
}
