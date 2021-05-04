import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foody/models/fooditemModel.dart';
import 'package:foody/user/constant/const.dart';
import 'package:foody/user/helper/screen_navigation.dart';
import 'package:foody/user/login/login.dart';
import 'package:foody/user/providers/categoryprovider.dart';
import 'package:foody/user/providers/my_provider.dart';
import 'package:foody/user/screens/cart.dart';
import 'package:foody/user/screens/featured_products.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class Menu extends StatefulWidget {
  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  String user_email = MyProvider().getUserMail();
  final _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  List<Category> listcategory = [];

  Widget drawerItem({@required String name, @required IconData icon}) {
    return ListTile(
      leading: Icon(icon),
      title: Text(
        name,
        style: TextStyle(color: Colors.black),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final MyProvider provider2 = Provider.of<MyProvider>(context);
    final CategoryProvider provider = Provider.of<CategoryProvider>(context);

    listcategory = provider.categories;

    int length = provider2.cartList.length;
    return Scaffold(
      drawer: Drawer(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              UserAccountsDrawerHeader(
                accountName: Text(
                  'Rana Awais' ?? 'Name Loading',
                  style: TextStyle(fontSize: 21),
                ),
                accountEmail: Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: Text(
                    '$user_email' ?? 'Email Loading',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  //changeScreen(context, EmployeeProfile());
                },
                child: drawerItem(
                  icon: Icons.person,
                  name: "Employees",
                ),
              ),
              GestureDetector(
                onTap: () {
                  //changeScreen(context, ShowOrders());
                },
                child: drawerItem(
                  icon: Icons.card_travel,
                  name: "Orders",
                ),
              ),
              GestureDetector(
                onTap: () {
                  //changeScreen(context, Menu_Items());
                },
                child: drawerItem(
                  icon: Icons.fastfood,
                  name: "Food Items",
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: drawerItem(
                  icon: Icons.info,
                  name: 'Foody App  (version: 1.0)' +
                      '\n' +
                      'Developers: M. Junaid & M. Awais',
                ),
              ),
              Divider(
                thickness: 2,
                color: black,
              ),
              // GestureDetector(
              //   onTap: () {},
              //   child: drawerItem(
              //     icon: Icons.lock,
              //     name: "Change Password",
              //   ),
              // ),
              GestureDetector(
                onTap: () {
                  Alert(
                      context: context,
                      title: "LogOut",
                      content: Form(
                        key: formkey,
                        child: Column(
                          children: <Widget>[
                            TextFormField(
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                icon: Icon(Icons.lock),
                                labelText: 'Logout Password',
                              ),
                              validator: (value) {
                                // pNumber = value;
                                if (value != '12345') {
                                  return 'Enter Valid Password';
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                      ),
                      buttons: [
                        DialogButton(
                          onPressed: () {
                            if (formkey.currentState.validate()) {
                              setState(() {
                                _auth.signOut();
                                changeScreenReplacement(context, Login());
                              });
                            } else {
                              return null;
                            }
                          },
                          child: Text(
                            "Logout",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        )
                      ]).show();
                },
                child: drawerItem(
                  icon: Icons.logout,
                  name: "Logout",
                ),
              ),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        backgroundColor: kcolor2,
        title: Center(
          child: kappbartext,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 6),
            child: Stack(children: [
              IconButton(
                  icon: Icon(Icons.shopping_cart),
                  onPressed: () {
                    changeScreenReplacement(context, CartPage());
                  }),
              Positioned(
                top: 4,
                right: 0,
                child: Container(
                  height: 20,
                  width: 20,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: Colors.black),
                  child: Center(child: Text('$length')),
                ),
              ),
            ]),
          )
        ],
      ),
      resizeToAvoidBottomInset: false,
      // resizeToAvoidBottomPadding: true,

      body: Container(
        color: Colors.white,
        // physics: NeverScrollableScrollPhysics(),
        child: Column(children: [
          Container(
            child: Container(
              height: 170,
              width: double.infinity,
              child: Image.asset(
                "images/menu2.jpg",
                fit: BoxFit.cover,
              ),
            ),
          ),
          ListTile(
            tileColor: Colors.grey[200],
            title: Center(
              child: Text(
                'MENU',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Expanded(
            child: Featured(listcategory),
          )
        ]),
      ),
    );
  }
}
