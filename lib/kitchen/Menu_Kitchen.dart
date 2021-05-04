import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:foody/kitchen/Table_Data.dart';
import 'package:foody/kitchen/crud.dart';
import 'package:foody/models/orderModel.dart';

import 'package:foody/user/helper/orderData.dart';
import 'package:foody/user/helper/screen_navigation.dart';
import 'dart:async';

import 'package:toast/toast.dart';

class Menu_Kitchen extends StatefulWidget {
  @override
  _Menu_KitchenState createState() => _Menu_KitchenState();
}

class _Menu_KitchenState extends State<Menu_Kitchen> {
  OrderData orderData = OrderData();
  List<OrderModel> orderlist = List<OrderModel>();

  @override
  void initState() {
    // TODO: implement initState
    loadOrdersData();
    super.initState();
  }

  loadOrdersData() async {
    orderlist = await orderData.getkitchenDoc();
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
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
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
                      return Slidable(
                          key: ValueKey(index),
                          actionPane: SlidableDrawerActionPane(),
                          secondaryActions: [
                            IconSlideAction(
                                caption: 'Delete',
                                color: Colors.red.shade400,
                                icon: Icons.remove,
                                closeOnTap: true,
                                onTap: () {
                                  Toast.show(
                                      'Deleted ${orderlist[index].orderby}',
                                      context,
                                      duration: Toast.LENGTH_SHORT,
                                      gravity: Toast.BOTTOM);
                                  setState(() {
                                    Crud().delkitchen(orderlist[index].orderby);
                                    orderlist.removeAt(index);
                                  });
                                }),
                          ],
                          dismissal: SlidableDismissal(
                            child: SlidableDrawerDismissal(),
                          ),
                          child: Padding(
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
                          ));
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
