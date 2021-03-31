import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foody/user/screens/menu.dart';
import 'package:page_transition/page_transition.dart';

class ThankU extends StatefulWidget {
  @override
  _ThankUState createState() => _ThankUState();
}

class _ThankUState extends State<ThankU> {
  @override
  void initState() {
    // TODO: implement initState
    Timer(
        Duration(seconds: 3),
        () => (Navigator.pushReplacement(
            context,
            PageTransition(
                child: Menu(), type: PageTransitionType.leftToRightWithFade))));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: initScreen(context),
    );
  }

  initScreen(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              child: Image.asset("images/splash.jpg"),
            ),
            Padding(padding: EdgeInsets.only(top: 20.0)),
            CircularProgressIndicator(
              backgroundColor: Colors.white,
              strokeWidth: 1,
            )
          ],
        ),
      ),
    );
  }
}
