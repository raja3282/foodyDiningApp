import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foody/user/constant/const.dart';
import 'package:foody/user/helper/screen_navigation.dart';
import 'package:foody/user/providers/my_provider.dart';

import 'package:foody/user/screens/cart.dart';
import 'package:foody/user/screens/menu.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

class DetailPage extends StatefulWidget {
  final String image;
  final int price;
  final String name;
  double rating;
  final String productid;
  final String description;

  DetailPage({
    @required this.price,
    @required this.name,
    @required this.image,
    @required this.rating,
    @required this.productid,
    @required this.description,
  });
  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final String Useremail = MyProvider().getUserMail();

  //int quantity = 1;
  @override
  Widget build(BuildContext context) {
    MyProvider provider = Provider.of<MyProvider>(context);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: kcolor2,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              changeScreenReplacement(context, Menu());
            },
          ),
          title: Center(
            child: Padding(
              padding: const EdgeInsets.only(right: 32.0),
              child: kappbartext,
            ),
          ),
        ),
        body: SafeArea(
          child: Container(
            color: Colors.white,
            child: Column(
              children: [
                Container(
                  height: 380,
                  color: Colors.white,
                  child: Column(children: [
                    ListTile(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 2, horizontal: 2),
                      title: Center(
                        child: Text(
                          widget.name,
                          style: TextStyle(
                            fontSize: 30,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 180,
                      color: Colors.white,
                      child: Image.network(
                        widget.image,
                        height: 180,
                        width: 180,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 12.0),
                          child: Row(
                            children: [
                              Text(
                                widget.rating.toString(),
                                style: TextStyle(
                                  color: grey,
                                  fontSize: 17.0,
                                ),
                              ),
                              SizedBox(
                                width: 2,
                              ),
                              Icon(
                                Icons.star,
                                color: red,
                                size: 18,
                              ),
                              Icon(
                                Icons.star,
                                color: red,
                                size: 18,
                              ),
                              Icon(
                                Icons.star,
                                color: red,
                                size: 18,
                              ),
                              Icon(
                                Icons.star,
                                color: red,
                                size: 18,
                              ),
                              Icon(
                                Icons.star,
                                color: grey,
                                size: 18,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 12.0),
                          child: Text(
                            'Rs.${widget.price}',
                            style: TextStyle(
                              fontSize: 27,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      ],
                    ),
                    Divider(
                      indent: 9,
                      endIndent: 9,
                      thickness: 1,
                    ),
                    Container(
                      height: 60,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 53,
                            width: 180,
                            child: ElevatedButton(
                                // style: ButtonStyle(color:Colors.red[500],),

                                onPressed: () {
                                  provider.addToCart(
                                    id: widget.productid,
                                    name: widget.name,
                                    price: widget.price,
                                    image: widget.image,
                                    //quantity: quantity,
                                    Uemail: Useremail,
                                  );
                                  final snackBar = SnackBar(
                                    content:
                                        Text('${widget.name} added to Cart'),
                                    duration: Duration(milliseconds: 750),
                                    action: SnackBarAction(
                                      label: 'See Cart',
                                      onPressed: () {
                                        changeScreen(context, CartPage());
                                        setState(() {});
                                      },
                                    ),
                                  );

                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                  changeScreenReplacement(context, Menu());
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Add to cart',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ],
                                )),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      indent: 9,
                      endIndent: 9,
                      thickness: 1,
                    ),
                  ]),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 18, vertical: 0),
                    width: double.infinity,
                    color: Colors.white,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          widget.description,
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w300,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
