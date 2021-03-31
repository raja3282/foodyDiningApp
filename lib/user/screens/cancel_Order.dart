import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:foody/models/cartModel.dart';
import 'package:foody/user/constant/const.dart';
import 'package:foody/user/helper/screen_navigation.dart';
import 'package:foody/user/providers/my_provider.dart';
import 'package:foody/user/screens/menu.dart';
import 'package:foody/user/screens/payment.dart';
import 'package:provider/provider.dart';

class CancelOrder extends StatefulWidget {
  List<CartModel> cartList;
  int bill;
  CancelOrder({@required this.cartList, @required this.bill});

  @override
  _CancelOrderState createState() => _CancelOrderState();
}

class _CancelOrderState extends State<CancelOrder> {
  final db = FirebaseFirestore.instance;
  // MyProvider my = MyProvider();
  DateTime datetime = new DateTime.now();
  final String Useremail = MyProvider().getUserMail();
  @override
  Widget build(BuildContext context) {
    MyProvider provider = Provider.of<MyProvider>(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: kcolor2, //Color(0xff213777),
          centerTitle: true,
          title: Text(
            'Order',
            style: kappbarstyle,
          ),
        ),
        body: Container(
          color: Colors.white,
          child: Column(
            children: [
              Container(
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(24, 20, 0, 0),
                      child: Text(
                        'My order',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                indent: 10,
                endIndent: 10,
                thickness: 1,
              ),
              Container(
                color: Colors.white,
                height: 260,
                child: ListView.builder(
                  itemCount: widget.cartList?.length,
                  itemBuilder: (context, index) {
                    //return Text('item $index');
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: Container(
                          height: 130,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey[100],
                                offset: Offset(1, 1),
                                blurRadius: 30,
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              children: [
                                Image.network(
                                  widget.cartList[index].image,
                                  height: 60.0,
                                  width: 60.0,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: 200,
                                      child: RichText(
                                        text: TextSpan(
                                          children: [
                                            TextSpan(
                                              text:
                                                  widget.cartList[index].name +
                                                      '\n',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 20,
                                              ),
                                            ),
                                            TextSpan(
                                              text: 'price:' +
                                                  widget.cartList[index].price
                                                      .toString() +
                                                  '\n',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 14,
                                              ),
                                            ),
                                            TextSpan(
                                              text: 'Quantity:' +
                                                  widget
                                                      .cartList[index].quantity
                                                      .toString() +
                                                  '\n',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 13,
                                              ),
                                            ),
                                            TextSpan(
                                              text: 'Total: Rs' +
                                                  (widget.cartList[index]
                                                              .quantity *
                                                          widget.cartList[index]
                                                              .price)
                                                      .toString() +
                                                  '\n',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.bold),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )),
                    );
                  },
                ),
              ),
              Divider(
                indent: 10,
                endIndent: 10,
                thickness: 1,
              ),
              Container(
                color: Colors.white,
                height: 60,
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Total: ',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
                    ),
                    SizedBox(
                      width: 80,
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 12),
                          child: Text(
                            'Rs. ${widget.bill}',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Divider(
                indent: 10,
                endIndent: 10,
                thickness: 1,
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Container(
                        color: Colors.black,
                        height: 55,
                        width: 130,
                        child: RaisedButton(
                          color: Colors.red[500],
                          onPressed: () {
                            provider.cancelorder();
                            changeScreenReplacement(
                              context,
                              Menu(),
                            );
                            setState(() {});
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'CANCEL',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Container(
                        color: Colors.black,
                        height: 55,
                        width: 130,
                        child: RaisedButton(
                          color: Colors.red[500],
                          onPressed: () async {
                            provider.addt(widget.bill, datetime);
                            provider.addkt(widget.bill, datetime);
                            String doc = await provider.getdocumentid(
                                datetime, Useremail);
                            changeScreenReplacement(
                              context,
                              Payment(widget.bill, doc),
                            );
                            setState(() {});
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'CONFIRM',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
