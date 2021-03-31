import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foody/user/constant/const.dart';
import 'package:foody/user/helper/roundedButton.dart';
import 'package:foody/user/login/login.dart';
import 'package:foody/user/screens/menu.dart';
import 'package:foody/user/signup/registeration.dart';

import '../helper/screen_navigation.dart';

class Welcome extends StatefulWidget {
  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  AnimationController controller;
  Animation animation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Column(
              children: <Widget>[
                Container(
                  child: Hero(
                    tag: 'logo',
                    child: Container(
                      child: Image.asset(
                        'images/logo.png',
                      ),
                      height: 100,
                      width: 100,
                    ),
                  ),
                ),
                Container(
                  child: Center(
                    child: Text(
                      'FOODY',
                      style: TextStyle(
                        color: kcolor2,
                        fontFamily: 'Pacifico',
                        fontSize: 50.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 80.0,
            ),
            RoundedButton(
              title: 'LogIn',
              color: kcolor2,
              onPressed: () {
                changeScreen(context, Login());
              },
            ),
            RoundedButton(
              title: 'SignUp',
              color: kcolor2,
              onPressed: () {
                changeScreen(context, Registration());
              },
            ),
          ],
        ),
      ),
    );
  }
}
