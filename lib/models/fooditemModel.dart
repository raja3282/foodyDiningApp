import 'package:flutter/cupertino.dart';

class Category {
  final String id;
  final String name;
  final String image;
  final int price;
  final String description;
  final double rating;

  Category({
    @required this.id,
    @required this.price,
    @required this.name,
    @required this.image,
    @required this.rating,
    @required this.description,
  });
}
