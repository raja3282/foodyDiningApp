import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foody/admin/Employee_Profile.dart';
import 'package:foody/admin/menu_items.dart';
import 'package:foody/admin/showOrders.dart';
import 'package:foody/user/constant/const.dart';
import 'file:///C:/Users/Cv/AndroidStudioProjects/foody/lib/user/providers/my_provider.dart';
import 'package:foody/user/login/login.dart';
import 'file:///C:/Users/Cv/AndroidStudioProjects/foody/lib/user/helper/screen_navigation.dart';

class Home extends StatelessWidget {
  final _auth = FirebaseAuth.instance;
  String user_email = MyProvider().getUserMail();
  Widget drawerItem({@required String name, @required IconData icon}) {
    return ListTile(
      leading: Icon(icon),
      title: Text(
        name,
        style: TextStyle(
          color: Colors.black,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              UserAccountsDrawerHeader(
                accountName: Text('Rana Awais'),
                accountEmail: Text('$user_email'),
              ),
              GestureDetector(
                onTap: () {
                  changeScreen(context, EmployeeProfile());
                },
                child: drawerItem(
                  icon: Icons.person,
                  name: "Employees",
                ),
              ),
              GestureDetector(
                onTap: () {
                  changeScreen(context, ShowOrders());
                },
                child: drawerItem(
                  icon: Icons.card_travel,
                  name: "Orders",
                ),
              ),
              GestureDetector(
                onTap: () {
                  changeScreen(context, Menu_Items());
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
                  name: "About",
                ),
              ),
              Divider(
                thickness: 2,
                color: black,
              ),
              GestureDetector(
                onTap: () {},
                child: drawerItem(
                  icon: Icons.lock,
                  name: "Change Password",
                ),
              ),
              GestureDetector(
                onTap: () {
                  _auth.signOut();
                  changeScreen(context, Login());
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
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {},
        ),
        actions: [
          IconButton(
              icon: Icon(Icons.notification_important_outlined),
              onPressed: () {})
        ],
        title: Center(
          child: kappbartext,
        ),
      ),
      body: Container(
        color: Colors.white,
        // physics: NeverScrollableScrollPhysics(),
        child: Column(
          children: [
            Container(
              height: 210,
              width: double.infinity,
              child: Image.asset(
                "images/admin1.jpg",
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 26, 10, 0),
              child: Container(
                width: 340,
                height: 150,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      child: Container(
                        ////////////////Employee/////////////////////////
                        height: 150,
                        width: 160,
                        child: Image.asset(
                          "images/ava.jpg",
                          fit: BoxFit.fill,
                          // height: 150,
                          // width: 170,
                        ),
                      ),
                      onTap: () {
                        changeScreen(context, EmployeeProfile());
                      },
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Container(
                      height: 125,
                      width: 160,
                      child: GestureDetector(
                        child: Image.asset(
                          "images/foodIcon.jpg",
                          fit: BoxFit.contain,
                          height: 80,
                          width: 150,
                        ),
                        onTap: () {
                          changeScreen(context, Menu_Items());
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'Employee',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 20),
                ),
                SizedBox(
                  width: 1,
                ),
                Text(
                  'Menu Items',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 20),
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            GestureDetector(
              child: Container(
                height: 120,
                width: 120,
                child: Image.asset(
                  "images/order.png",
                  fit: BoxFit.fill,
                ),
              ),
              onTap: () {
                changeScreen(context, ShowOrders());
              },
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Orders',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
