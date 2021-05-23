import 'package:flutter/cupertino.dart';

class userModel {
  final String name;
  final String email;
  final String password;

  userModel({
    @required this.name,
    @required this.email,
    this.password,
  });
}
