import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:foody/admin/Table_Data.dart';
import 'package:foody/user/constant/const.dart';

import 'package:foody/user/helper/orderData.dart';
import 'file:///C:/Users/Cv/AndroidStudioProjects/foody/lib/models/orderModel.dart';

import 'file:///C:/Users/Cv/AndroidStudioProjects/foody/lib/user/helper/screen_navigation.dart';
import 'dart:async';

class ShowOrders extends StatefulWidget {
  @override
  _ShowOrdersState createState() => _ShowOrdersState();
}

class _ShowOrdersState extends State<ShowOrders> {
  OrderData orderData = OrderData();
  List<OrderModel> orderlist;

  @override
  void initState() {
    // TODO: implement initState
    loadOrdersData();
    super.initState();
  }

  loadOrdersData() async {
    orderlist = await orderData.getAllDoc();
    print('orderlist: ' + orderlist.length.toString());
    setState(() {});
  }

  Future<Null> refreshList() async {
    await setState(() {
      loadOrdersData();
    });
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.orange[800], //Color(0xff213777),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // changeScreen(context, Menu());
          },
        ),
        title: Center(
            child: Text(
          'All Orders',
          style: kappbarstyle,
        )),
      ),
      body: Container(
        width: double.infinity,
        color: Colors.white,
        child: Column(
          children: [
            Container(
              child: Expanded(
                child: RefreshIndicator(
                  child: ListView.builder(
                    physics: ScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemCount: orderlist?.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Container(
                          height: 65,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color: Colors.grey,
                              width: 1,
                            ),
                          ),
                          child: Center(
                            child: ListTile(
                              leading: Text(
                                orderlist[index].orderby,
                                style: TextStyle(
                                  fontSize: 17,
                                ),
                              ),
                              trailing: Text(
                                (orderlist[index].datetime).toString(),
                                style: TextStyle(
                                  fontSize: 12,
                                ),
                              ),
                              onTap: () {
                                changeScreen(
                                    context, TableData(orderlist[index]));
                              },
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  onRefresh: refreshList,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
