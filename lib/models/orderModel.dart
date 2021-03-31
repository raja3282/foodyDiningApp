import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class OrderModel {
  //final String orderby;
  final List<dynamic> productsId;
  final List<dynamic> quantity;
  final DateTime datetime;
  final String orderby;
  final int total;
  DocumentReference reference;

  OrderModel.fromMap(Map<String, dynamic> map, {this.reference})
      : productsId = map['products'].toList(),
        quantity = map['quantity'].toList(),
        orderby = map['orderby'],
        datetime = map['datetime'].toDate(),
        total = map['total'];
  OrderModel.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data(), reference: snapshot.reference);
}
