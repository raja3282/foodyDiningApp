import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:foody/models/cartModel.dart';
import 'package:foody/user/constant/const.dart';
import 'package:foody/user/helper/screen_navigation.dart';
import 'package:foody/user/providers/my_provider.dart';
import 'package:foody/user/screens/cancel_Order.dart';
import 'package:foody/user/screens/menu.dart';
import 'package:provider/provider.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<CartModel> cartList = [];
  final db = FirebaseFirestore.instance;

  DateTime datetime = new DateTime.now();

  @override
  Widget Cartitem(
      {@required image,
      @required name,
      @required price,
      @required quantity,
      @required Function onTap,
      @required Function increment,
      @required Function decrement}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Container(
        height: 160,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey[100],
              offset: Offset(1, 1),
              blurRadius: 8,
            ),
          ],
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(14.0),
              child: Row(
                children: [
                  Image.network(
                    image,
                    height: 65.0,
                    width: 65.0,
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 200,
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: name + '\n',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                ),
                              ),
                              TextSpan(
                                text: 'price:' + price.toString() + '\n',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                ),
                              ),
                              TextSpan(
                                text: 'Quantity:' + quantity.toString() + '\n',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 13,
                                ),
                              ),
                              TextSpan(
                                text: 'Total: Rs' +
                                    (quantity * price).toString() +
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
                      SizedBox(
                        width: 25,
                      ),
                      IconButton(
                        iconSize: 36,
                        icon: Icon(Icons.delete_outline_rounded),
                        onPressed: () {
                          onTap();
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 14.0),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        decrement();
                      });
                    },
                    child: Container(
                      height: 37,
                      width: 37,
                      decoration: BoxDecoration(
                        color: Colors.red[500],
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Icon(
                        Icons.remove,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(
                      quantity.toString(),
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 24,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        increment();
                      });
                    },
                    child: Container(
                      height: 37,
                      width: 37,
                      decoration: BoxDecoration(
                        color: Colors.red[500],
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget build(BuildContext context) {
    MyProvider provider = Provider.of<MyProvider>(context);
    int bill = provider.total();

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: kcolor2, //Color(0xff213777),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              changeScreenReplacement(context, Menu());
            },
          ),
          title: Padding(
            padding: const EdgeInsets.only(left: 100.0),
            child: Text(
              'CART',
              style: kappbarstyle,
            ),
          ),
        ),
        body: Container(
          color: Colors.white,
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Container(
                color: Colors.white,
                height: 320,
                child: provider.cartList.length > 0
                    ? ListView.builder(
                        itemCount: provider.cartList.length,
                        itemBuilder: (context, index) {
                          return Cartitem(
                              image: provider.cartList[index].image,
                              name: provider.cartList[index].name,
                              price: provider.cartList[index].price,
                              quantity: provider.cartList[index].quantity,
                              onTap: () {
                                provider.deleteitemfromcart(index);
                              },
                              increment: () {
                                provider.increaseQuantity(index);
                              },
                              decrement: () {
                                provider.decreaseQuantity(index);
                              });
                        },
                      )
                    : noItemContainer(),
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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Total: ',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
                    ),
                    SizedBox(
                      width: 100,
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 12),
                          child: Text(
                            'Rs. $bill',
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
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(34.0),
                child: Container(
                    color: Colors.black,
                    height: 55,
                    width: 190,
                    child: provider.cartList.length > 0
                        ? RaisedButton(
                            color: Colors.red[500],
                            onPressed: () {
                              changeScreenReplacement(
                                context,
                                CancelOrder(
                                  bill: bill,
                                  cartList: provider.cartList,
                                ),
                              );
                              setState(() {});
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'CONTINUE',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 23,
                                  ),
                                ),
                              ],
                            ),
                          )
                        : RaisedButton(
                            color: Colors.grey[400],
                            onPressed: () {},
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'CONTINUE',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 23,
                                  ),
                                ),
                              ],
                            ),
                          )),
              )
            ],
          ),
        ),
      ),
    );
  }

  Container noItemContainer() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Your Cart Is Empty!!",
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[400],
                    fontSize: 20),
              ),
            ),
          ),
          Text(
            "Please add items to proceed..",
            style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.grey[400],
                fontSize: 20),
          ),
        ],
      ),
    );
  }
}
