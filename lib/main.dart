import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/cart.dart';
import 'package:shop_app/providers/products_provider.dart';
import 'package:shop_app/screens/home_page.dart';
import 'package:shop_app/screens/product_detail.dart';

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
        ChangeNotifierProvider(create:  (context) => Cart()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Your One Stop Food Place',
        theme: themeForApp(),
        home: const HomePage(),
        routes: {
          ProductDetail.routeName: (context) => const ProductDetail(),
        },
      ),
    );
  }

  ThemeData themeForApp() {
    return ThemeData(
      colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.red)
          .copyWith(secondary: Colors.orange),
      fontFamily: "Lato",
    );
  }
}
