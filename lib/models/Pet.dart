import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:petopia/models/Record.dart';

class Pet {
  String name;
  String notes;
  String type;

  List<Record> records;
  String userId;

  DocumentReference reference;

  Pet(this.name, this.userId, {this.notes, this.type, this.reference, this.records});

  factory Pet.fromSnapshot(DocumentSnapshot snapshot) {
    Pet newPet = Pet.fromJson(snapshot.data);
    newPet.reference = snapshot.reference;
    return newPet;
  }

  factory Pet.fromJson(Map<String, dynamic> json) => _PetFromJson(json);

  Map<String, dynamic> toJson() => _PetToJson(this);
  @override
  String toString() => "Pet<$name>";
}

Pet _PetFromJson(Map<String, dynamic> json) {
  return Pet(
      json['name'] as String,
      json['userId'] as String,
      notes: json['notes'] as String,
      type: json['type'] as String,
      records: _convertRecords(json['records'] as List)
  );
}

List<Record> _convertRecords(List recordMap) {
  if (recordMap == null) {
    return null;
  }
  List<Record> records =  List<Record>();
  recordMap.forEach((value) {
    recordMap.add(Record.fromJson(value));
  });
  return records;
}

Map<String, dynamic> _PetToJson(Pet instance) => <String, dynamic> {
  'name': instance.name,
  'notes': instance.notes,
  'type': instance.type,
  'records': _RecordList(instance.records),
  'userId': instance.userId
};

List<Map<String, dynamic>> _RecordList(List<Record> records) {
  if (records == null) {
    return null;
  }
  List<Map<String, dynamic>> recordMap =List<Map<String, dynamic>>();
  records.forEach((record) {
    recordMap.add(record.toJson());
  });
  return recordMap;
}
