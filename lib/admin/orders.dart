import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'file:///C:/Users/Cv/AndroidStudioProjects/foody/lib/user/helper/appBar.dart';
import 'package:foody/employee/employee_data.dart';
import 'file:///C:/Users/Cv/AndroidStudioProjects/foody/lib/models/employee_model.dart';

class Order extends StatefulWidget {
  @override
  _OrderState createState() => _OrderState();
}

class _OrderState extends State<Order> {
  List<EmployeeModel> employeeList;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          App_Bar(),
          dateChips(context),
          orderData(context),
        ],
      ),
    );
  }

  Widget dateChips(BuildContext context) {
    return Positioned(
      top: 120,
      child: Container(
        width: 400,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ActionChip(
                backgroundColor: Colors.indigo,
                label: Text(
                  'Today',
                  style: TextStyle(
                    fontFamily: 'Pasifico',
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
                onPressed: () {}),
            ActionChip(
                backgroundColor: Colors.indigo,
                label: Text(
                  'This Week',
                  style: TextStyle(
                    fontFamily: 'Pasifico',
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
                onPressed: () {
                  setState(() {});
                }),
            ActionChip(
                backgroundColor: Colors.indigo,
                label: Text(
                  'This Month',
                  style: TextStyle(
                    fontFamily: 'Pasifico',
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
                onPressed: () {}),
          ],
        ),
      ),
    );
  }

  Widget orderData(BuildContext) {
    return Container(
      height: 600,
      color: Colors.white,
      // physics: NeverScrollableScrollPhysics(),
      child: Column(
        children: [
          Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                'Employees',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    color: Colors.black),
              ),
            ),
          ),
          Divider(
            indent: 10,
            endIndent: 10,
            thickness: 1,
          ),
          Expanded(
            child: ListView.builder(
              physics: ScrollPhysics(),
              scrollDirection: Axis.vertical,
              itemCount: employeeList?.length ?? 0,
              shrinkWrap: true,
              itemBuilder: (_, index) {
                return Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Container(
                      decoration: BoxDecoration(
                        //color: const Color(0xff7c94b6),
                        border: Border.all(
                          color: Colors.black,
                          width: 1,
                        ),
                      ),
                      width: double.infinity,
                      height: 180,
                      //color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            // Text(
                            //   employeeList[index].id,
                            //   style: TextStyle(
                            //     color: Colors.black,
                            //     fontWeight: FontWeight.w300,
                            //     fontSize: 15,
                            //   ),
                            // ),
                            Text(
                              employeeList[index].name,
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                                fontSize: 18,
                              ),
                            ),
                            Text(
                              employeeList[index].salary.toString(),
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w300,
                                fontSize: 15,
                              ),
                            ),
                            Text(
                              employeeList[index].empNo,
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w300,
                                fontSize: 15,
                              ),
                            ),
                            Row(
                              children: [],
                            )
                          ],
                        ),
                      )),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
