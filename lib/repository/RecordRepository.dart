import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:petopia/models/Record.dart';

class RecordRepository {
  final CollectionReference collection = Firestore.instance.collection('records');

  Stream<QuerySnapshot> getStream() {
    return collection.snapshots();
  }

  Future<DocumentReference> addRecord(Record record) {
    return collection.add(record.toJson());
  }

  updateRecord(Record record) async {
    await collection.document(record.reference.documentID).updateData(record.toJson());
  }
}
