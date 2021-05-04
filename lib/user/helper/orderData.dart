import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foody/models/data.dart';
import 'package:foody/models/orderModel.dart';
import 'package:foody/models/paymentmodel.dart';

//////////on document data myorder/////////////////////
class OrderData {
  final db = FirebaseFirestore.instance;

  ///////////documents load all/////////////////////////

  // Future<List<OrderModel>> getAllDoc() async {
  //   QuerySnapshot snapshot = await db.collection('myOrder').get();
  //   List<OrderModel> ordersList =
  //       snapshot.docs.map((doc) => OrderModel.fromSnapshot(doc)).toList();
  //   return ordersList;
  // }

  ///////////////////////////for kitchen///////////////////////////////////
  Future<List<OrderModel>> getkitchenDoc() async {
    QuerySnapshot snapshot = await db.collection('kitchen').get();
    List<OrderModel> ordersList =
        snapshot.docs.map((doc) => OrderModel.fromSnapshot(doc)).toList();
    return ordersList;
  }

  // /////////////////////product list load///////////////////////////
  // Future<List<Data>> getListOfProducts() async {
  //   OrderData my = OrderData();
  //   List<Data> categoryListt = List();
  //   //List<Data> categorylist = List();
  //   QuerySnapshot snapshot = await db.collection('myOrder').get();
  //   List<OrderModel> ordersList =
  //       snapshot.docs.map((doc) => OrderModel.fromSnapshot(doc)).toList();
  //   for (int j = 0; j < ordersList.length; j++) {
  //     for (int i = 0; i < ordersList[j].productsId.length; i++) {
  //       DocumentSnapshot query = await db
  //           .collection('category')
  //           .doc(ordersList[j].productsId[i])
  //           .get();
  //       Data category = Data.fromSnapshot(query);
  //       categoryListt.add(category);
  //     }
  //   }
  //   return categoryListt;
  // }

///////////////////////////product Ids List//////////////////////////////////////
  Future<List<Data>> getListOfProductsByIDS({@required idslist}) async {
    List<Data> listofproduct = [];
    for (int j = 0; j < idslist.length; j++) {
      DocumentSnapshot query =
          await db.collection('category').doc(idslist[j]).get();
      Data category = Data.fromSnapshot(query);
      listofproduct.add(category);
    }
    return listofproduct;
  }

  ////////////////////////////////////////////////////////////////////////////////////
  //
  // Future<List<OrderModel>> getListOfUser(String userId) async {
  //   db
  //       .collection('myOrder')
  //       .where('orderby', isEqualTo: userId)
  //       .get()
  //       .then((result) {
  //     List<OrderModel> orders = [];
  //     for (DocumentSnapshot order in result.docs) {
  //       orders.add(OrderModel.fromSnapshot(order));
  //     }
  //     return orders;
  //   });
  // }

  Future<PaymentModel> getpaymentByIDS({@required idslist}) async {
    var snapshot = await db
        .collection('myOrder')
        .doc(idslist)
        .collection('payment')
        .doc()
        .get();
    PaymentModel payment = PaymentModel.fromSnapshot(snapshot);
  }
}
