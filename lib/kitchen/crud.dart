import 'package:cloud_firestore/cloud_firestore.dart';

final db = FirebaseFirestore.instance;

class Crud {
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
}
