import 'package:cloud_firestore/cloud_firestore.dart';

class PaymentModel {
  String name;
  String number;
  String method;
  DocumentReference reference;

  PaymentModel.fromMap(Map<String, dynamic> map, {this.reference})
      : name = map['name'],
        number = map['number'],
        method = map['method'];

  PaymentModel.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data(), reference: snapshot.reference);
}
