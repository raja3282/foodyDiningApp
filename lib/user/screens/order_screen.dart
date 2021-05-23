import 'package:chips_choice/chips_choice.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:foody/user/constant/const.dart';
import 'package:foody/user/helper/order_services.dart';
import 'package:foody/user/providers/order_provider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class MyOrders extends StatefulWidget {
  @override
  _MyOrdersState createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {
  OrderServices _OrderServices = OrderServices();
  User user = FirebaseAuth.instance.currentUser;

  int tag = 0;
  List<String> options = [
    'All Orders',
    'Ordered',
    'Accepted',
    'Rejected',
    'Being Prepared',
    'Ready To Serve',
    'Completed',
  ];
  @override
  Widget build(BuildContext context) {
    var _orderProvider = Provider.of<OrderProvider>(context);
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: kcolor2,
        title: Text(
          'My Orders',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            height: 56,
            width: MediaQuery.of(context).size.width,
            child: ChipsChoice<int>.single(
              choiceActiveStyle: C2ChoiceStyle(
                color: Colors.teal,
              ),
              choiceStyle: C2ChoiceStyle(
                borderRadius: BorderRadius.all(Radius.circular(3)),
              ),
              value: tag,
              onChanged: (val) => setState(() {
                if (val == 0) {
                  setState(() {
                    _orderProvider.status = null;
                  });
                }
                setState(() {
                  tag = val;
                  _orderProvider.filterOrder(options[val]);
                });
              }),
              choiceItems: C2Choice.listFrom<int, String>(
                source: options,
                value: (i, v) => i,
                label: (i, v) => v,
              ),
            ),
          ),
          Container(
            child: StreamBuilder<QuerySnapshot>(
              stream: _OrderServices.orders
                  .where('userId', isEqualTo: user.uid)
                  .where('orderStatus',
                      isEqualTo: tag > 0 ? _orderProvider.status : null)
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text('Something went wrong');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (snapshot.data.size == 0) {
                  //TODO no order screen
                  return Center(
                    child: Text(tag > 0
                        ? 'No ${options[tag]} orders'
                        : 'No Orders. Continue Shopping'),
                  );
                }

                return Expanded(
                  child: new ListView(
                    children:
                        snapshot.data.docs.map((DocumentSnapshot document) {
                      return new Container(
                        color: Colors.white,
                        child: Column(
                          children: [
                            ListTile(
                              horizontalTitleGap: 0,
                              leading: CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 14,
                                child: Icon(
                                  CupertinoIcons.square_list,
                                  size: 18,
                                  color: document.data()['orderStatus'] ==
                                          'Accepted'
                                      ? Colors.blueGrey[400]
                                      : document.data()['orderStatus'] ==
                                              'Rejected'
                                          ? Colors.red
                                          : document.data()['orderStatus'] ==
                                                  'Cancelled'
                                              ? Colors.red[300]
                                              : document.data()[
                                                          'orderStatus'] ==
                                                      'Completed'
                                                  ? Colors.green
                                                  : Colors.orangeAccent,
                                ),
                              ),
                              title: Text(
                                document.data()['orderStatus'],
                                style: TextStyle(
                                    fontSize: 12,
                                    color: document.data()['orderStatus'] ==
                                            'Accepted'
                                        ? Colors.blueGrey[400]
                                        : document.data()['orderStatus'] ==
                                                'Rejected'
                                            ? Colors.red
                                            : document.data()['orderStatus'] ==
                                                    'Cancelled'
                                                ? Colors.red[300]
                                                : document.data()[
                                                            'orderStatus'] ==
                                                        'Completed'
                                                    ? Colors.green
                                                    : Colors.orangeAccent,
                                    fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(
                                'On ${DateFormat.yMMMd().format(
                                  DateTime.parse(document.data()['timestamp']),
                                )}',
                                style: TextStyle(fontSize: 12),
                              ),
                              trailing: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'Table : ${document.data()['userEmail']}',
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 1,
                                  ),
                                  Text(
                                    'Amount : PKR ${document.data()['total'].toStringAsFixed(0)}',
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                            ExpansionTile(
                              title: Text(
                                'Order details',
                                style: TextStyle(
                                    fontSize: 10, color: Colors.black),
                              ),
                              subtitle: Text(
                                'View order details',
                                style:
                                    TextStyle(fontSize: 12, color: Colors.grey),
                              ),
                              children: [
                                ListView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return ListTile(
                                      leading: CircleAvatar(
                                        //radius: 20,
                                        backgroundColor: Colors.white,
                                        child: Image.network(
                                            document.data()['products'][index]
                                                ['productImage']),
                                      ),
                                      title: Text(
                                        document.data()['products'][index]
                                            ['productName'],
                                        style: TextStyle(fontSize: 13),
                                      ),
                                      subtitle: Text(
                                        '${document.data()['products'][index]['quantity'].toString()} x PKR ${document.data()['products'][index]['productPrice'].toString()}',
                                        style: TextStyle(
                                            color: Colors.grey, fontSize: 12),
                                      ),
                                    );
                                  },
                                  itemCount: document.data()['products'].length,
                                ),
                              ],
                            ),
                            Divider(
                              height: 3,
                              color: Colors.grey,
                            ),
                            document.data()['orderStatus'] == 'Ordered'
                                ? Container(
                                    color: Colors.grey[300],
                                    height: 50,
                                    width: MediaQuery.of(context).size.width,
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          40, 8, 40, 8),
                                      child: FlatButton(
                                        color: Colors.blueGrey,
                                        child: Text(
                                          'Cancel Order',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        onPressed: () {
                                          EasyLoading.show(
                                              status: 'Updating status');
                                          _OrderServices.updateOrderStatus(
                                                  document.id, 'Cancelled')
                                              .then((value) {
                                            EasyLoading.showSuccess(
                                                'Updated successfully');
                                          });
                                        },
                                      ),
                                    ),
                                  )
                                : document.data()['orderStatus'] == 'Accepted'
                                    ? Container(
                                        color: Colors.grey[300],
                                        height: 50,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: FlatButton(
                                            color: Colors.blueGrey,
                                            child: Text(
                                              'Cancel Order',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                            onPressed: () {
                                              EasyLoading.show(
                                                  status: 'Updating status');
                                              _OrderServices.updateOrderStatus(
                                                      document.id, 'Cancelled')
                                                  .then((value) {
                                                EasyLoading.showSuccess(
                                                    'Updated successfully');
                                              });
                                            },
                                          ),
                                        ),
                                      )
                                    : Container(),
                            Divider(
                              height: 3,
                              color: Colors.grey,
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
