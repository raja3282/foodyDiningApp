import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'file:///C:/Users/Cv/AndroidStudioProjects/foody/lib/models/AttendanceMark.dart';

import 'file:///C:/Users/Cv/AndroidStudioProjects/foody/lib/models/employee_model.dart';

class EmployeeData {
  /////////////////////////////Retrieve Employeee Data//////////////////////
  final db = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  Future<List<EmployeeModel>> getListOfEployee() async {
    List<EmployeeModel> categoryListt = List();
    //List<Data> categorylist = List();
    QuerySnapshot snapshot = await db.collection('Employee').get();
    List<EmployeeModel> employeeList =
        snapshot.docs.map((doc) => EmployeeModel.fromSnapshot(doc)).toList();

    return employeeList;
  }

/////////////////////////////Add Employeee Data//////////////////////
  Future<void> add(String name, String id, String empNo, int salary) async {
    try {
      db.collection('Employee').doc().set({
        'name': '$name',
        'id': '$id',
        'EmpNo': '$empNo',
        'Salary': '$salary',
      });
    } catch (e) {
      print(e.toString());
    }
  }

  //////////////////////////Update Employee/////////////////////////////
  Future<void> update(String name, String updated_name, String id, String empNo,
      int salary) async {
    db
        .collection('Employee')
        .where('name', isEqualTo: name)
        .get()
        .then((result) {
      for (DocumentSnapshot document in result.docs) {
        document.reference.set({
          'name': '$updated_name',
          'id': '$id',
          'EmpNo': '$empNo',
          'Salary': '$salary'
        });
      }
    });
  }
  ///////////documents load all/////////////////////////

  Future<List<EmployeeModel>> getAllDoc() async {
    QuerySnapshot snapshot = await db.collection('Employee').get();
    List<EmployeeModel> EmployeeList =
        snapshot.docs.map((doc) => EmployeeModel.fromSnapshot(doc)).toList();
    return EmployeeList;
  }

  /////////////////////////////////attendance id List////////////////////////////////////////
  Future<List<Attendence>> getListOfAttendanceByIDS({@required idslist}) async {
    QuerySnapshot snapshot = await db
        .collection('Employee')
        .doc(idslist)
        .collection('attendence')
        .get();
    List<Attendence> attendanceList =
        snapshot.docs.map((doc) => Attendence.fromSnapshot(doc)).toList();
    // print(attendanceList[0].timein);
    return attendanceList;
  }
}
