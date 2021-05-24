import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foody/models/cartModel.dart';
import 'package:foody/models/fooditemModel.dart';
import 'package:foody/user/helper/order_services.dart';

class MyProvider extends ChangeNotifier {
  OrderServices _orderServices = OrderServices();
  final db = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  User loggedInUser;
  CollectionReference cart = FirebaseFirestore.instance.collection('cart');

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
        comparedPrice: element.data()['comparedPrice'],
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

  Future<void> addToCart({
    @required String id,
    String name,
    String image,
    int price,
    int comparedPrice,
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
        cartModel = CartModel(
            name: name,
            image: image,
            price: price,
            id: id,
            comparedPrice: comparedPrice);
        newCartList.add(cartModel);
        cartList = newCartList;
        cart.doc(getCurrentUser()).set({
          'uid': getCurrentUser(),
        });
        return cart.doc(getCurrentUser()).collection('products').add({
          'productName': name,
          'productID': id,
          'productImage': image,
          'productPrice': price,
          'productComparedprice': comparedPrice,
          'quantity': 1,
        });
      }
    } else {
      cartModel = CartModel(
          name: name,
          image: image,
          price: price,
          id: id,
          comparedPrice: comparedPrice);
      newCartList.add(cartModel);
      cartList = newCartList;

      cart.doc(getCurrentUser()).set({
        'uid': getCurrentUser(),
      });
      return cart.doc(getCurrentUser()).collection('products').add({
        'productName': name,
        'productID': id,
        'productImage': image,
        'productPrice': price,
        'productComparedprice': comparedPrice,
        'quantity': 1,
      });
    }
    return null;
  }

  get getcartList => cartList;

//////////////if selected item is already in the cart//////////////////
  void increaseItemQuantity(CartModel foodItem) async {
    foodItem.incrementQuantity();
    await db
        .collection('cart')
        .doc(getCurrentUser())
        .collection('products')
        .where('productID', isEqualTo: foodItem.id)
        .get()
        .then((result) {
      for (DocumentSnapshot document in result.docs) {
        document.reference.update({'quantity': foodItem.quantity});
      }
    });
  }

  // void decreaseItemQuantity(CartModel foodItem) {
  //   foodItem.decrementQuantity();
  // }

////////////////////////////////////////////////
  int total() {
    int total = 0;
    cartList.forEach((element) {
      total += element.price * element.quantity;
    });
    return total;
  }

  Future<void> deleteitemfromcart(int index) async {
    await db
        .collection('cart')
        .doc(getCurrentUser())
        .collection('products')
        .where('productID', isEqualTo: cartList[index].id)
        .get()
        .then((result) {
      for (DocumentSnapshot document in result.docs) {
        document.reference.delete();
      }
    });
    cartList.removeAt(index);
    notifyListeners();
  }

  /////////////////(+ and - )quantity buttons///////////////////////////////
  void increaseQuantity(int index) async {
    cartList[index].incrementQuantity();
    notifyListeners();
    await db
        .collection('cart')
        .doc(getCurrentUser())
        .collection('products')
        .where('productID', isEqualTo: cartList[index].id)
        .get()
        .then((result) {
      for (DocumentSnapshot document in result.docs) {
        document.reference.update({'quantity': cartList[index].quantity});
      }
    });
  }

  void decreaseQuantity(int index) async {
    if (cartList[index].quantity > 1) {
      cartList[index].decrementQuantity();
    }
    notifyListeners();
    await db
        .collection('cart')
        .doc(getCurrentUser())
        .collection('products')
        .where('productID', isEqualTo: cartList[index].id)
        .get()
        .then((result) {
      for (DocumentSnapshot document in result.docs) {
        document.reference.update({'quantity': cartList[index].quantity});
      }
    });
  }

  int cartlength() {
    return cartList.length;
  }

  ////////////////////cancel order/////////////////////////////////////////
  // void cancelorder() {
  //   cartList.clear();
  //   newCartList.clear();
  //   notifyListeners();
  //   cart.doc(getCurrentUser()).delete();
  // }

  Future<void> checkData() async {
    final snapshot =
        await cart.doc(getCurrentUser()).collection('products').get();
    if (snapshot.docs.length == 0) {
      cart.doc(getCurrentUser()).delete();
    }
  }

  Future<void> deleteCart() async {
    final result = await cart
        .doc(getCurrentUser())
        .collection('products')
        .get()
        .then((snapshot) {
      for (DocumentSnapshot ds in snapshot.docs) {
        ds.reference.delete();
      }
    });
  }

  saveOrder(int total, DateTime dateTime) async {
    List listCart = [];
    List _newlistCart = [];
    QuerySnapshot snapshot =
        await cart.doc(getCurrentUser()).collection('products').get();
    if (snapshot == null) {
      return null;
    }
    snapshot.docs.forEach((doc) {
      if (!_newlistCart.contains(doc.data())) {
        _newlistCart.add(doc.data());
        listCart = _newlistCart;
        notifyListeners();
      }
    });
    DocumentSnapshot snapshot2 =
        await db.collection('diningUsers').doc(_auth.currentUser.email).get();
    _orderServices.saveOrder({
      'products': listCart,
      'userId': getCurrentUser(),
      'TableNumber': snapshot2.data()['name'],
      'userEmail': UserId,
      'total': total,
      'timestamp': dateTime.toString(),
      'orderStatus': 'Ordered',
      'payment': {
        'orderby': '',
        'method': '',
        'total': '',
        'pNo': '',
      },
    }).then((value) {
      deleteCart().then((value) {
        checkData();
      });
    });
    cartList.clear();
    newCartList.clear();
  }

  //////////user id//////////////////////////////////////////
  String getCurrentUser() {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
      }
    } catch (e) {
      print(e);
    }
    return loggedInUser.uid;
  }

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

/////////////////////////////payment db///////////////////////////////////////

  Future<void> addpayment(
      int bill, String datetime, String method, String name, String no) async {
    await db
        .collection('diningOrder')
        .where('userId', isEqualTo: getCurrentUser())
        .where('total', isEqualTo: bill)
        .where('timestamp', isEqualTo: datetime)
        .get()
        .then((result) {
      for (DocumentSnapshot document in result.docs) {
        document.reference.update({
          'payment': {
            'orderby': name,
            'method': method,
            'total': bill,
            'pNo': no,
          }
        });
      }
      print('--------------------------------------------------------------');
      print(bill);
      print(datetime.toString());
    });
  }
}
