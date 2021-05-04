import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:foody/models/cartModel.dart';
import 'package:foody/models/fooditemModel.dart';

class MyProvider extends ChangeNotifier {
  final db = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  User loggedInUser;

  List<Category> categoryList = [];
  List<Category> newCategoryList = [];
  Category category;

  Future<List<Category>> getCategory() async {
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
    return categoryList;
  }

  get throwcategoryList {
    return categoryList;
  }

  ///////////////Add to cart//////////////////////////////////////////

  List<CartModel> cartList = [];

  String UserId;

  List<CartModel> newCartList = [];
  CartModel cartModel;

  void addToCart({
    @required String id,
    String name,
    String image,
    int price,
    @required String Uemail,
  }) {
    UserId = Uemail.toString();
    bool isPresent = false;

    if (cartList.length > 0) {
      for (int i = 0; i < cartList.length; i++) {
        if (cartList[i].id == id) {
          increaseItemQuantity(cartList[i]);
          isPresent = true;
          break;
        } else {
          isPresent = false;
        }
      }

      if (!isPresent) {
        cartModel = CartModel(name: name, image: image, price: price, id: id);
        newCartList.add(cartModel);
        cartList = newCartList;
      }
    } else {
      cartModel = CartModel(name: name, image: image, price: price, id: id);
      newCartList.add(cartModel);
      cartList = newCartList;
    }
  }

  get throwcartList {
    return cartList;
  }

//////////////if selected item is already in the cart//////////////////
  void increaseItemQuantity(CartModel foodItem) {
    foodItem.incrementQuantity();
  }

  void decreaseItemQuantity(CartModel foodItem) {
    foodItem.decrementQuantity();
  }

////////////////////////////////////////////////
  int total() {
    int total = 0;
    cartList.forEach((element) {
      total += element.price * element.quantity;
    });
    return total;
  }

  void deleteitemfromcart(int index) {
    cartList.removeAt(index);
    notifyListeners();
  }

  /////////////////(+ and - )quantity buttons///////////////////////////////
  void increaseQuantity(int index) {
    cartList[index].incrementQuantity();
    notifyListeners();
  }

  void decreaseQuantity(int index) {
    if (cartList[index].quantity > 1) {
      cartList[index].decrementQuantity();
    }
    notifyListeners();
  }

  int cartlength() {
    return cartList.length;
  }

  ////////////////////cancel order/////////////////////////////////////////
  void cancelorder() {
    cartList.clear();
    newCartList.clear();
    notifyListeners();
  }

///////////////////////storing ids and quantities//////////////////////////////////////
  List<String> cartIDsList = [];
  List<String> newcartIDsList = [];
  List<int> cartQuantityList = [];
  List<int> newcartQuantityList = [];
  List<String> getCartItemsIDs() {
    for (int i = 0; i < cartList.length; i++) {
      newcartIDsList.add(cartList[i].id);
      cartIDsList = newcartIDsList;
    }
    return cartIDsList;
  }

  List<int> getQuantity() {
    for (int i = 0; i < cartList.length; i++) {
      newcartQuantityList.add(cartList[i].quantity);
      cartQuantityList = newcartQuantityList;
    }
    return cartQuantityList;
  }

  //////////////////////////Add to db///////////////////////////////////////////////

  void addt(int total, DateTime datetime) {
    cartIDsList = getCartItemsIDs();
    cartQuantityList = getQuantity();
    try {
      db.collection('myOrder').doc().set({
        'orderby': UserId,
        'products': cartIDsList,
        'quantity': cartQuantityList,
        'total': total,
        'datetime': datetime,
        // 'quantity': order.quantity,
        // 'image': order.image,
      });
    } catch (e) {
      print(e.toString());
    }
  }

///////////////////////////kitchen data//////////////////////////////////////////////

  void addkt(int total, DateTime datetime) {
    cartIDsList = getCartItemsIDs();
    cartQuantityList = getQuantity();
    try {
      db.collection('kitchen').doc().set({
        'orderby': UserId,
        'products': cartIDsList,
        'quantity': cartQuantityList,
        'total': total,
        'datetime': datetime,
        // 'quantity': order.quantity,
        // 'image': order.image,
      });
    } catch (e) {
      print(e.toString());
    }
    cartIDsList.clear();
    cartQuantityList.clear();
    cartList.clear();
    newCartList.clear();
    newcartQuantityList.clear();
    newcartIDsList.clear();
  }

  ////////////user id//////////////////////////////////////////
  // String getCurrentUser() {
  //   try {
  //     final user = _auth.currentUser;
  //     if (user != null) {
  //       loggedInUser = user;
  //     }
  //   } catch (e) {
  //     print(e);
  //   }
  //   return loggedInUser.uid;
  // }

  String getUserMail() {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
      }
    } catch (e) {
      print(e);
    }
    return loggedInUser.email;
  }

///////////payment db//////////////////////////////

  Future<String> getdocumentid(DateTime datetime, String useremail) async {
    String doc;
    await db
        .collection('myOrder')
        .where('orderby', isEqualTo: useremail)
        .where('datetime', isEqualTo: datetime)
        .get()
        .then((result) {
      for (DocumentSnapshot document in result.docs) {
        doc = document.reference.id;
      }
      print('--------------------------------------------------------------');
      print(doc);
    });
    return doc;
  }

  Future<void> addpayment(
      int total, String docc, String method, String name, String no) async {
    // print('${order.name}');
    //QuerySnapshot query = await db.collection('category').get();
    try {
      await db.collection('myOrder').doc(docc).collection('payment').doc().set({
        'orderby': name,
        'method': method,
        'total': total,
        'pNo': no,
        //   db.collection('myOrder').doc(id).collection('Payment').doc().set({

        // 'quantity': order.quantity,
        // 'image': order.image,
      });
    } catch (e) {
      print(e.toString());
    }
  }
}
