import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foody/user/constant/const.dart';
import 'package:foody/user/helper/screen_navigation.dart';
import 'package:foody/user/providers/my_provider.dart';
import 'package:foody/user/screens/thankuPage.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class Payment extends StatefulWidget {
  final int bill;
  final DateTime datetime;
  Payment(this.bill, this.datetime);
  @override
  _PaymentState createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  String userName;
  String pNumber;
  String method;
  bool _easypaisavisible = true;
  bool _jazz = false;
  bool btnPressed = false;
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    MyProvider provider = Provider.of<MyProvider>(context);
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: btnPressed == true
            ? Container(
                margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
                height: 60,
                decoration: BoxDecoration(
                    color: Colors.red[500],
                    borderRadius: BorderRadius.circular(10.0)),
                child: FlatButton(
                  onPressed: () {
                    changeScreen(context, ThankU());
                  },
                  child: Text(
                    'PROCEED',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w300,
                        fontSize: 24),
                  ),
                ),
              )
            : Container(
                margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
                height: 60,
                decoration: BoxDecoration(
                    color: Colors.grey[500],
                    borderRadius: BorderRadius.circular(10.0)),
                child: FlatButton(
                  onPressed: () {},
                  child: Text(
                    'PROCEED',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w300,
                        fontSize: 24),
                  ),
                ),
              ),
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: kcolor2, //Color(0xff213777),
          title: Text(
            'PAYMENT',
            style: kappbarstyle,
          ),
          centerTitle: true,
        ),
        body: Container(
          color: Colors.white,
          child: Column(
            children: [
              Container(
                color: kcolor2,
                height: 150,
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Total Price',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w300,
                            fontSize: 20),
                      ),
                      Text(
                        'Rs.${widget.bill.toString()}',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w300,
                            fontSize: 50),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        child: Container(
                          child: Image.asset(
                            'images/easypaisa.jpg',
                            fit: BoxFit.fill,
                            height: 70,
                            width: 70,
                          ),
                        ),
                        onTap: () {
                          setState(() {
                            Alert(
                                context: context,
                                title: "EasyPaisa Payment Info",
                                content: Form(
                                  key: formkey,
                                  child: Column(
                                    children: <Widget>[
                                      TextFormField(
                                          keyboardType: TextInputType.text,
                                          decoration: InputDecoration(
                                            icon: Icon(Icons
                                                .drive_file_rename_outline),
                                            labelText: 'Name',
                                          ),
                                          validator: (value) {
                                            userName = value;
                                            if (value.isEmpty) {
                                              return 'Please Enter Valid name';
                                            }
                                            return null;
                                          }),
                                      TextFormField(
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                          icon: Icon(Icons.phone),
                                          labelText: 'EasyPaisa Number',
                                        ),
                                        validator: (value) {
                                          pNumber = value;
                                          if (value.isEmpty) {
                                            return 'Please Enter Valid value';
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
                                          method = 'EasyPaisa';
                                          provider.addpayment(
                                              widget.bill,
                                              widget.datetime,
                                              method,
                                              userName,
                                              pNumber);
                                          Navigator.pop(context);
                                          btnPressed = true;
                                        });
                                      } else {
                                        btnPressed = false;
                                        return null;
                                      }
                                    },
                                    child: Text(
                                      "SEND",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20),
                                    ),
                                  )
                                ]).show();
                            _easypaisavisible = !_easypaisavisible;
                            if (_jazz == true) {
                              _jazz = !_jazz;
                            }
                          });
                        },
                      ),
                      Container(
                        height: 70,
                        width: 70,
                        child: GestureDetector(
                          child: Image.network(
                            "https://firebasestorage.googleapis.com/v0/b/foodyfyp.appspot.com/o/images%2Fjazzcash.jpg?alt=media&token=4ce10739-581d-40c0-b3ba-0a01795f89c7",
                            fit: BoxFit.contain,
                          ),
                          onTap: () {
                            setState(() {
                              Alert(
                                  context: context,
                                  title: "JazzCash Payment Info",
                                  content: Form(
                                    key: formkey,
                                    child: Column(
                                      children: <Widget>[
                                        TextFormField(
                                            keyboardType: TextInputType.text,
                                            decoration: InputDecoration(
                                              icon: Icon(Icons
                                                  .drive_file_rename_outline),
                                              labelText: 'Name',
                                            ),
                                            validator: (value) {
                                              userName = value;
                                              if (value.isEmpty) {
                                                return 'Please Enter Valid name';
                                              }
                                              return null;
                                            }),
                                        TextFormField(
                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
                                            icon: Icon(Icons.phone),
                                            labelText: 'JazzCash Number',
                                          ),
                                          validator: (value) {
                                            pNumber = value;
                                            if (value.isEmpty) {
                                              return 'Please Enter Valid value';
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
                                            method = 'JazzCash';
                                            provider.addpayment(
                                                widget.bill,
                                                widget.datetime,
                                                method,
                                                userName,
                                                pNumber);
                                            Navigator.pop(context);
                                            btnPressed = true;
                                          });
                                        } else {
                                          btnPressed = false;
                                          return null;
                                        }
                                      },
                                      child: Text(
                                        "SEND",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 20),
                                      ),
                                    )
                                  ]).show();
                              _jazz = !_jazz;
                              if (_easypaisavisible == true) {
                                _easypaisavisible = !_easypaisavisible;
                              }
                            });
                            //changeScreen(context, Menu_Items());
                          },
                        ),
                      ),
                      Container(
                        height: 70,
                        width: 70,
                        child: GestureDetector(
                          child: Image.network(
                            "https://firebasestorage.googleapis.com/v0/b/foodyfyp.appspot.com/o/images%2Fhandpayment.png?alt=media&token=7595d628-3f69-492f-b5e4-a3bdc98d68ac",
                            fit: BoxFit.contain,
                            // height: 80,
                            // width: 150,
                          ),
                          onTap: () {
                            setState(() {
                              Alert(
                                  context: context,
                                  title: "Hand Payment",
                                  content: Container(
                                    child: Padding(
                                      padding: const EdgeInsets.all(20.0),
                                      child: Text(
                                        'Pay your bill to waiter..Thankyou!',
                                        style: TextStyle(fontSize: 14),
                                      ),
                                    ),
                                  ),
                                  buttons: [
                                    DialogButton(
                                      onPressed: () {
                                        setState(() {
                                          method = 'By hand';
                                          provider.addpayment(
                                              widget.bill,
                                              widget.datetime,
                                              method,
                                              userName = 'Not Available',
                                              pNumber = 'Not Available');

                                          Navigator.pop(context);
                                          btnPressed = true;
                                        });
                                      },
                                      child: Text(
                                        "Got It",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 20),
                                      ),
                                    )
                                  ]).show();
                            });

                            //changeScreen(context, Menu_Items());
                          },
                        ),
                      )
                    ]),
              ),
              SizedBox(
                height: 20,
              ),
              Visibility(
                visible: _easypaisavisible,
                child: Column(
                  children: [
                    Container(
                      height: 300,
                      width: 320,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.green,
                          width: 0.3,
                        ),
                        color: Colors.green,
                        image: DecorationImage(
                            image: NetworkImage(
                                'https://4.bp.blogspot.com/_fqgP02TDHV4/TULQpNsbA1I/AAAAAAAAAW0/FvXMaNe7zB4/s1600/QRcode_frompage.jpg'),
                            fit: BoxFit.cover),
                      ),
                    ),
                  ],
                ),
              ),
              Visibility(
                visible: _jazz,
                child: Container(
                  height: 300,
                  width: 320,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.red,
                      width: 0.3,
                    ),
                    image: DecorationImage(
                        image: NetworkImage(
                            'https://4.bp.blogspot.com/_fqgP02TDHV4/TULQpNsbA1I/AAAAAAAAAW0/FvXMaNe7zB4/s1600/QRcode_frompage.jpg'),
                        fit: BoxFit.cover),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
