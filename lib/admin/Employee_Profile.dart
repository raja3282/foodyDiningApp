import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foody/admin/attendence.dart';
import 'package:foody/admin/crud.dart';
import 'package:foody/admin/home.dart';
import 'package:foody/employee/employee_data.dart';
import 'file:///C:/Users/Cv/AndroidStudioProjects/foody/lib/models/employee_model.dart';
import 'package:foody/user/constant/const.dart';
import 'file:///C:/Users/Cv/AndroidStudioProjects/foody/lib/user/helper/screen_navigation.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'dart:async';

class EmployeeProfile extends StatefulWidget {
  @override
  _EmployeeProfileState createState() => _EmployeeProfileState();
}

class _EmployeeProfileState extends State<EmployeeProfile> {
  List<EmployeeModel> employeeList;
  static const wadges = 700;
  String id;
  String name;
  String empNo;
  int salary;
  @override
  void initState() {
    getEmp();

    super.initState();
  }

  getEmp() async {
    employeeList = await EmployeeData().getListOfEployee();

    setState(() {});
  }

  Future<Null> refreshList() async {
    await setState(() {
      getEmp();
    });
    return null;
  }

  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: kcolor2, //Color(0xff213777),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              changeScreen(context, Home());
            },
          ),
          title: Padding(
            padding: const EdgeInsets.only(left: 85.0),
            child: Text(
              'FOODY',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
            ),
          ),
        ),
        body: Container(
          // height: double.infinity,
          color: Colors.white,
          // physics: NeverScrollableScrollPhysics(),
          child: Column(
            children: [
              ListTile(
                  leading: Text(
                    'Employees Information',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.teal),
                  ),
                  trailing: RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          side: BorderSide(color: Colors.blueGrey)),
                      child: Text(
                        'Add +',
                        style: TextStyle(
                            fontWeight: FontWeight.w400, fontSize: 20),
                      ),
                      onPressed: () {
                        setState(() {
                          _popup(context);
                        });
                      })),
              Divider(
                indent: 10,
                endIndent: 10,
                thickness: 2,
                color: Colors.black,
              ),
              Expanded(
                child: RefreshIndicator(
                  child: ListView.builder(
                    physics: ScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemCount: employeeList?.length ?? 0,
                    shrinkWrap: true,
                    itemBuilder: (_, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 14),
                        child: Container(
                            decoration: BoxDecoration(
                              //color: const Color(0xff7c94b6),
                              border: Border.all(
                                color: Colors.grey[400],
                                width: 1,
                              ),
                            ),
                            width: double.infinity,

                            //color: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    'Name:  ${employeeList[index].name}',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 18,
                                    ),
                                  ),
                                  Text(
                                    'ID:  ${employeeList[index].id}',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w300,
                                      fontSize: 15,
                                    ),
                                  ),
                                  Text(
                                    'Phone Number:  ${employeeList[index].empNo}',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w300,
                                      fontSize: 16,
                                    ),
                                  ),
                                  Text(
                                    'Salary:  ${(employeeList[index].attendanceCount * wadges).toString()}',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w300,
                                      fontSize: 16,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 45,
                                  ),
                                  ListTile(
                                    leading: RaisedButton(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(3.0),
                                            side: BorderSide(
                                                color: Colors.blueGrey)),
                                        child: Text(
                                          'Attendance',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 20),
                                        ),
                                        onPressed: () {
                                          changeScreen(
                                              context,
                                              AttendancePage(
                                                  employeeList[index]));
                                        }),
                                    trailing: RaisedButton(
                                        color: Colors.red[700],
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(3.0),
                                            side: BorderSide(
                                                color: Colors.blueGrey)),
                                        child: Text(
                                          'Delete',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 20),
                                        ),
                                        onPressed: () {
                                          Crud().Empdelete(
                                              employeeList[index].name);
                                        }),
                                  ),
                                ],
                              ),
                            )),
                      );
                    },
                  ),
                  onRefresh: refreshList,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _popup(context) {
    Alert(
        context: context,
        title: "Add New Employee",
        content: Form(
          key: formkey,
          child: Column(
            children: <Widget>[
              TextFormField(
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  icon: Icon(Icons.drive_file_rename_outline),
                  labelText: 'Name',
                ),
                validator: (value) {
                  name = value;
                  if (value.isEmpty) {
                    return 'Please Enter Name';
                  }
                  return null;
                },
              ),
              TextFormField(
                keyboardType: TextInputType.url,
                decoration: InputDecoration(
                  icon: Icon(Icons.phone),
                  labelText: ' Employee Phone No',
                ),
                validator: (value) {
                  empNo = value;
                  if (value.isEmpty) {
                    return 'Please Enter Phone Number';
                  }
                  return null;
                },
              ),
              TextFormField(
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  icon: Icon(Icons.credit_card),
                  labelText: 'Eployee Id ',
                ),
                validator: (value) {
                  id = value;
                  if (value.isEmpty) {
                    return 'Please Enter ID';
                  }
                  return null;
                },
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  icon: Icon(Icons.money),
                  labelText: 'Salary',
                ),
                validator: (value) {
                  salary = int.parse(value);
                  assert(salary is int);
                  if (value.isEmpty) {
                    return 'Please Enter Salary';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
        buttons: [
          DialogButton(
            onPressed: () {
              if (formkey.currentState.validate()) {
                setState(() {
                  Crud().addEmp(name, empNo, id, salary);
                  Navigator.pop(context);
                });
              } else {
                return null;
              }
            },
            child: Text(
              "Add Employee",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          )
        ]).show();
  }
}
