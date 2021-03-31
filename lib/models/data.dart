import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class Data {
  final String id;
  final String name;
  final String image;
  final int price;
  DocumentReference reference;

  Data.fromMap(Map<String, dynamic> map, {this.reference})
      : id = map['id'],
        name = map['name'],
        image = map['image'],
        price = map['price'];
  Data.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data(), reference: snapshot.reference);
}

// /////////////////////product list load///////////////////////////
// Future<List<OrderModel>> getListOfProducts() async {
//   List<Category> categorylist = List();
//   QuerySnapshot snapshot = await db.collection('myOrder').get();
//   List<OrderModel> ordersList =
//   snapshot.docs.map((doc) => OrderModel.fromSnapshot(doc)).toList();
//
//   for (int i = 0; i < ordersList[0].productsId.length; i++) {
//     DocumentSnapshot query = await db
//         .collection('category')
//         .doc(ordersList[0].productsId[i])
//         .get();
//
//     Category cateogy = Category.fromSnapshot(query);
//     categoryList.add(cateogy);
//   }
