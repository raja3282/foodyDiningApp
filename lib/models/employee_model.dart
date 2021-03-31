import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class EmployeeModel {
  final String id;
  final String name;
  final String empNo;
  final int salary;
  final int attendanceCount;
  DocumentReference reference;

  EmployeeModel.fromMap(Map<String, dynamic> map, {this.reference})
      : id = map['id'],
        name = map['EmpName'],
        empNo = map['EmpNo'],
        salary = map['Salary'],
        attendanceCount = map['attendencecount'];

  EmployeeModel.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data(), reference: snapshot.reference);
}
