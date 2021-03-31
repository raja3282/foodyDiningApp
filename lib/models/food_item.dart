import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foody/models/fooditemModel.dart';

class Myadd {
  final db = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  User loggedInUser;
  List<Category> categoryList = [];
  List<Category> newCategoryList = [];
  Category category;

  Future<void> getCategory() async {
    //print('hello rana the great');
    QuerySnapshot query = await db.collection('category').get();

    query.docs.forEach((element) {
      category = Category(
        id: element.reference.id,
        price: element.data()['price'],
        name: element.data()['name'],
        image: element.data()['image'],
        rating: element.data()['rating'],
        description: element.data()['description'],
      );

      newCategoryList.add(category);
      categoryList = newCategoryList;
    });
  }

  get throwcategoryList {
    return categoryList;
  }
}

FooditemList fooditemList = Myadd().throwcategoryList;

class FooditemList {
  List<FoodItem> foodItems;

  FooditemList({@required this.foodItems});
}

class FoodItem {
  final String id;
  final String name;
  final String image;
  final int price;
  final String description;
  double rating;
  int quantity;

  FoodItem({
    @required this.id,
    @required this.price,
    @required this.name,
    @required this.image,
    @required this.rating,
    @required this.description,
    this.quantity = 1,
  });

  void incrementQuantity() {
    this.quantity = this.quantity + 1;
  }

  void decrementQuantity() {
    this.quantity = this.quantity - 1;
  }
}
