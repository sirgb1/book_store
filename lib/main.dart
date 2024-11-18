import 'package:book_store1/screens/auth_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/cart_provider.dart';
import 'screens/home_page.dart';
import 'screens/cart_page.dart';
import 'screens/book_details_page.dart';
import 'screens/auth_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartProvider()),
      ],
      child: MaterialApp(
        title: 'Bookstore App',
        theme: ThemeData(fontFamily: 'MyCustomFont', primarySwatch: Colors.blue),
        home: AuthPage(),
      ),
    );
  }
}
