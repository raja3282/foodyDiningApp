import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'file:///C:/Users/Cv/AndroidStudioProjects/foody/lib/models/orderModel.dart';

final db = FirebaseFirestore.instance;

class Crud {
  Future<void> delete(String name) async {
    await db
        .collection('category')
        .where('name', isEqualTo: name)
        .get()
        .then((result) {
      for (DocumentSnapshot document in result.docs) {
        document.reference.delete();
      }
    });
  }

///////////////////del food//////////////////////////
  Future<void> delkitchen(String name) async {
    await db
        .collection('kitchen')
        .where('orderby', isEqualTo: name)
        .get()
        .then((result) {
      for (DocumentSnapshot document in result.docs) {
        document.reference.delete();
      }
    });
  }

  Future<void> update(
      String name, String updated_name, int price, String image) async {
    await db
        .collection('category')
        .where('name', isEqualTo: name)
        .get()
        .then((result) {
      for (DocumentSnapshot document in result.docs) {
        document.reference
            .set({'name': updated_name, 'price': price, 'image': image});
      }
    });
  }

  Future<void> add(String name, int price, String image) async {
    try {
      await db.collection('category').doc().set({
        'name': name,
        'price': price,
        'image': image,
      });
    } catch (e) {
      print(e.toString());
    }
  }

  //////////////////////////////////add employee////////////////////////////////
  Future<void> addEmp(String name, String EmpNo, String id, int Salary) async {
    try {
      await db.collection('Employee').doc().set({
        'EmpName': name,
        'EmpNo': EmpNo,
        'id': id,
        'Salary': Salary,
      });
    } catch (e) {
      print(e.toString());
    }
  }

////////////////////////Delete Employee/////////////////////////////////////////
  Future<void> Empdelete(String name) async {
    await db
        .collection('Employee')
        .where('EmpName', isEqualTo: name)
        .get()
        .then((result) {
      for (DocumentSnapshot document in result.docs) {
        document.reference.delete();
      }
    });
  }
  // Future<void>showRecord()async{
  //   try{
  //     db.collection()
  //   }
  //   catch(e){}
  // }
//////////////////
}
