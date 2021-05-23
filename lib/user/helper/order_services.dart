import 'package:cloud_firestore/cloud_firestore.dart';

class OrderServices {
  CollectionReference orders =
      FirebaseFirestore.instance.collection('diningOrder');
  Future<DocumentReference> saveOrder(Map<String, dynamic> data) {
    var result = orders.add(data);
    return result;
  }

  Future<void> updateOrderStatus(documentID, status) {
    var result = orders.doc(documentID).update({'orderStatus': status});
    return result;
  }
}
