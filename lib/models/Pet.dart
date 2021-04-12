import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:petopia/models/Record.dart';

class Pet {
  // 1
  String name;
  String notes;
  String type;
  // 2
  List<Record> records;
  // 3
  DocumentReference reference;
  // 4
  Pet(this.name, {this.notes, this.type, this.reference, this.records});
  // 5
  factory Pet.fromSnapshot(DocumentSnapshot snapshot) {
    Pet newPet = Pet.fromJson(snapshot.data);
    newPet.reference = snapshot.reference;
    return newPet;
  }
  // 6
  factory Pet.fromJson(Map<String, dynamic> json) => _PetFromJson(json);
  // 7
  Map<String, dynamic> toJson() => _PetToJson(this);
  @override
  String toString() => "Pet<$name>";
}

// 1
Pet _PetFromJson(Map<String, dynamic> json) {
  return Pet(
      json['name'] as String,
      notes: json['notes'] as String,
      type: json['type'] as String,
      records: _convertRecords(json['records'] as List)
  );
}
// 2
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
// 3
Map<String, dynamic> _PetToJson(Pet instance) => <String, dynamic> {
  'name': instance.name,
  'notes': instance.notes,
  'type': instance.type,
  'records': _RecordList(instance.records),
};
// 4
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
