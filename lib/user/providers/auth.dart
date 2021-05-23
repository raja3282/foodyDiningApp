import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class Authentication with ChangeNotifier {
  final _auth = FirebaseAuth.instance;
  final db = FirebaseFirestore.instance;
  DocumentSnapshot snapshot;

  Future<void> createUserRecord(
      String email, String name, String password) async {
    try {
      await db
          .collection('diningUsers')
          .doc(email)
          .set({'name': name, 'email': email, 'password': password});
    } catch (e) {
      print(e.toString());
    }
    return null;
  }

  Future<DocumentSnapshot> getUsereDtails() async {
    DocumentSnapshot result =
        await db.collection('diningUsers').doc(_auth.currentUser.email).get();
    this.snapshot = result;
    notifyListeners();

    return result;
  }
}
