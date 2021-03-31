import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'file:///C:/Users/Cv/AndroidStudioProjects/foody/lib/models/AttendanceMark.dart';
import 'package:foody/admin/showRecords.dart';
import 'file:///C:/Users/Cv/AndroidStudioProjects/foody/lib/models/employee_model.dart';
import 'package:foody/user/constant/const.dart';
import 'file:///C:/Users/Cv/AndroidStudioProjects/foody/lib/user/helper/screen_navigation.dart';

class AttendancePage extends StatefulWidget {
  final EmployeeModel employeModel;
  AttendancePage(this.employeModel);
  @override
  _AttendancePageState createState() => _AttendancePageState();
}

class _AttendancePageState extends State<AttendancePage> {
  final db = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kcolor2,
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {},
        ),
        actions: [
          IconButton(
              icon: Icon(Icons.notification_important_outlined),
              onPressed: () {})
        ],
        title: Center(
          child: Text(
            'FOODY',
            style: TextStyle(
              fontFamily: 'Pasifico',
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: Container(
        color: Colors.white,
        // physics: NeverScrollableScrollPhysics(),
        child: Column(
          children: [
            Container(
              height: 210,
              width: double.infinity,
              child: Image.asset(
                "images/Employee.jpg",
                fit: BoxFit.fill,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 26, 10, 0),
                  child: Container(
                    width: 340,
                    height: 150,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          child: Container(
                            height: 150,
                            width: 150,
                            child: Image.asset(
                              "images/absent.jpg",
                              fit: BoxFit.fill,
                              // height: 150,
                              // width: 170,
                            ),
                          ),
                          onTap: () {
                            db
                                .collection('Employee')
                                .doc(widget.employeModel.reference.id)
                                .collection('attendence')
                                .doc()
                                .set({
                              'today': DateTime.now(),
                              'timein': 'n/a',
                              'timeout': 'n/a',
                              'status': 'Absent'
                            });
                          },
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        Container(
                          height: 150,
                          width: 150,
                          child: GestureDetector(
                            child: Image.asset(
                              "images/checkIn.png",
                              fit: BoxFit.contain,
                              height: 80,
                              width: 150,
                            ),
                            onTap: () {
                              db
                                  .collection('Employee')
                                  .doc(widget.employeModel.reference.id)
                                  .collection('attendence')
                                  .doc()
                                  .set({
                                'timein': DateTime(DateTime.now().year,
                                    DateTime.now().month, DateTime.now().day),
                                'status': 'Present'
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 35.0),
                  child: Text(
                    'Absent',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 20),
                  ),
                ),
                SizedBox(
                  width: 100,
                ),
                Text(
                  'checkIn/presnt',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 20),
                ),
              ],
            ),
            Container(
              width: 340,
              height: 150,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    child: Container(
                      height: 140,
                      width: 100,
                      child: Image.asset(
                        "images/checkIn.jpg",
                        fit: BoxFit.fill,
                        height: 80,
                        width: 120,
                      ),
                    ),
                    onTap: () async {
                      final snapshot = await db
                          .collection('Employee')
                          .doc(widget.employeModel.reference.id)
                          .collection('attendence')
                          .where(
                            'timein',
                            isEqualTo: DateTime(DateTime.now().year,
                                DateTime.now().month, DateTime.now().day),
                          )
                          .get();
                      print('snapshot: ' + snapshot.docs.length.toString());
                      Attendence attendence =
                          Attendence.fromSnapshot(snapshot.docs[0]);
                      db
                          .collection('Employee')
                          .doc(widget.employeModel.reference.id)
                          .collection('attendence')
                          .doc(attendence.reference.id)
                          .update(
                              {'timeout': DateTime.now(), 'status': 'Present'});
                      db
                          .collection('Employee')
                          .doc(widget.employeModel.reference.id)
                          .update({'attendencecount': FieldValue.increment(1)});
                    },
                  ),
                  Container(
                    height: 125,
                    width: 160,
                    child: GestureDetector(
                      child: Image.asset(
                        "images/record.png",
                        fit: BoxFit.contain,
                        height: 80,
                        width: 150,
                      ),
                      onTap: () {
                        changeScreen(context, ShowRecords(widget.employeModel));
                      },
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'Check Out',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 20),
                ),
                SizedBox(
                  width: 1,
                ),
                Text(
                  'Show Record',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 20),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
