import 'package:cloud_firestore/cloud_firestore.dart';

class Attendence {
  DateTime timein;
  DateTime timeout;
  String status;
  DocumentReference reference;

  Attendence.fromMap(Map<String, dynamic> map, {this.reference})
      : timein = map['timein']?.toDate(),
        timeout = map['timeout']?.toDate(),
        status = map['status'];

  Attendence.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data(), reference: snapshot.reference);
}
