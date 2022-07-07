import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/cart.dart';
import 'package:shop_app/providers/orders.dart';
import 'package:shop_app/providers/products_provider.dart';
import 'package:shop_app/screens/cart_screen.dart';
import 'package:shop_app/screens/home_page.dart';
import 'package:shop_app/screens/product_detail.dart';

import 'screens/orders_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => Products()),
        ChangeNotifierProvider(create: (context) => Cart()),
        ChangeNotifierProvider(create: (context) => Orders()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Your One Stop Food Place',
        theme: themeForApp(),
        home: const HomePage(),
        routes: {
          ProductDetail.routeName: (context) => const ProductDetail(),
          CartScreen.routeName: (context) => const CartScreen(),
          OrdersScreen.routeName: (context) => const OrdersScreen(),
        },
      ),
    );
  }

  ThemeData themeForApp() {
    return ThemeData(
      colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.orange)
          .copyWith(secondary: Colors.red),
      fontFamily: "Lato",
    );
  }
}
