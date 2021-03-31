import 'package:flutter/material.dart';
import 'package:foody/user/constant/const.dart';

class App_Bar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: kcolor2,
      leading: IconButton(
        icon: Icon(Icons.menu),
        onPressed: () {},
      ),
      actions: [
        IconButton(
            icon: Icon(Icons.notification_important_outlined), onPressed: () {})
      ],
      title: Center(
        child: Text(
          'ORDERS',
          style: TextStyle(
            fontFamily: 'Pasifico',
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
