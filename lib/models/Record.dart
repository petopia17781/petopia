import 'package:cloud_firestore/cloud_firestore.dart';

class Record {
  DateTime date;
  bool vaccinated;
  bool dewormed;
  double weight;
  double calories;
  DocumentReference petRef;

  Record(this.date, {this.vaccinated, this.dewormed, this.weight, this.calories, this.petRef});

  factory Record.fromJson(Map<dynamic, dynamic> json) => _RecordFromJson(json);

  Map<String, dynamic> toJson() => _RecordToJson(this);
  @override
  String toString() => "Record<$Record>";
}

Record _RecordFromJson(Map<dynamic, dynamic> json) {
  return Record(
    json['date'] == null ? null : (json['date'] as Timestamp).toDate() as DateTime,
    vaccinated: json['vaccinated'] as bool,
    dewormed: json['dewormed'] as bool,
    weight: json['weight'] as double,
      calories: json['calories'] as double
  );
}

Map<String, dynamic> _RecordToJson(Record record) =>
    <String, dynamic> {
      'date': record.date,
      'vaccinated': record.vaccinated,
      'dewormed': record.dewormed,
      'weight': record.weight,
      'calories': record.calories
    };