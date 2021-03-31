import 'package:flutter/cupertino.dart';

class CartModel {
  final String id;
  final String name;
  final String image;
  final int price;
  int quantity;

  CartModel({
    @required this.id,
    @required this.name,
    @required this.image,
    @required this.price,
    this.quantity = 1,
  });
  get getquantity => quantity;
  get getid => id;

  void incrementQuantity() {
    this.quantity = this.quantity + 1;
  }

  void decrementQuantity() {
    this.quantity = this.quantity - 1;
  }
}
