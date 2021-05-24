import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foody/kitchen/kitchenScreen.dart';
import 'package:foody/user/providers/app.dart';
import 'package:foody/user/providers/auth.dart';
import 'package:foody/user/providers/categoryprovider.dart';
import 'package:foody/user/providers/my_provider.dart';
import 'package:foody/user/providers/order_provider.dart';
import 'package:foody/user/screens/splash.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(Foody());
}

class Foody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => (Authentication())),
        ChangeNotifierProvider(create: (_) => (MyProvider())),
        ChangeNotifierProvider(create: (_) => (AppProvider())),
        ChangeNotifierProvider(create: (_) => (OrderProvider())),
        ChangeNotifierProvider(create: (_) => (CategoryProvider.initialize()))
      ],
      child: MaterialApp(
        title: 'Foody',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.red,
          primaryColor: Colors.blueGrey,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: Splash(),
      ),
    );
  }
}
