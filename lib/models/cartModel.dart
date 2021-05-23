import 'package:flutter/cupertino.dart';

class CartModel {
  final String id;
  final String name;
  final String image;
  final int price;
  final int comparedPrice;
  int quantity;

  CartModel({
    @required this.id,
    @required this.name,
    @required this.image,
    @required this.price,
    @required this.comparedPrice,
    this.quantity = 1,
  });
  int get getquantity => quantity;
  String get getid => id;

  void incrementQuantity() {
    this.quantity = this.quantity + 1;
  }

  void decrementQuantity() {
    this.quantity = this.quantity - 1;
  }
}
