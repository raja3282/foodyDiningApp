import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'file:///C:/Users/Cv/AndroidStudioProjects/foody/lib/models/AttendanceMark.dart';
import 'package:foody/employee/employee_data.dart';
import 'file:///C:/Users/Cv/AndroidStudioProjects/foody/lib/models/employee_model.dart';
import 'package:foody/user/constant/const.dart';

class ShowRecords extends StatefulWidget {
  final EmployeeModel employeModel;
  ShowRecords(this.employeModel);
  @override
  _ShowRecordsState createState() => _ShowRecordsState();
}

class _ShowRecordsState extends State<ShowRecords> {
  final db = FirebaseFirestore.instance;
  List<Attendence> attendance = List();
  static const int wadges = 700;
  @override
  void initState() {
    getatt();
    // getprod();

    super.initState();
  }

  getatt() async {
    attendance = await EmployeeData()
        .getListOfAttendanceByIDS(idslist: widget.employeModel.reference.id);

    // OrderData()
    //     .getListOfProductsByIDS(idslist: orderModel.productsId);

    setState(() {});
  }

  Future<Null> refreshList() async {
    await setState(() {
      getatt();
    });
    return null;
  }

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
        child: Column(children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Attendance",
              textScaleFactor: 2,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Table(
              textDirection: TextDirection.ltr,
              defaultVerticalAlignment: TableCellVerticalAlignment.bottom,
              border: TableBorder.all(width: 3.0, color: Colors.blue),
              children: [
                TableRow(children: [
                  Text(
                    '  name',
                    style: TextStyle(fontWeight: FontWeight.bold),
                    textScaleFactor: 1.5,
                  ),
                  Text(' checkIn',
                      style: TextStyle(fontWeight: FontWeight.bold),
                      textScaleFactor: 1.5),
                  Text(' checkOut',
                      style: TextStyle(fontWeight: FontWeight.bold),
                      textScaleFactor: 1.5),
                ]),
              ]),
          Expanded(
            child: RefreshIndicator(
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: attendance?.length,
                  itemBuilder: (_, index) {
                    return Table(
                      textDirection: TextDirection.ltr,
                      defaultVerticalAlignment:
                          TableCellVerticalAlignment.middle,
                      border:
                          TableBorder.all(width: 2.0, color: Colors.black54),
                      children: [
                        TableRow(children: [
                          Text("${widget.employeModel.name}",
                              textScaleFactor: 1.5),
                          Text("${attendance[index].timeout}",
                              textScaleFactor: 1.5),
                          Text(
                            '${attendance[index].timein}',
                            textScaleFactor: 1.5,
                          ),
                        ]),
                      ],
                    );
                  }),
              onRefresh: refreshList,
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.only(right: 8.0, top: 8.0),
              child: Row(
                children: [
                  Spacer(),
                  Text(
                    'Present: ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    widget.employeModel.attendanceCount.toString(),
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
