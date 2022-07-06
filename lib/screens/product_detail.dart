import "package:flutter/material.dart";
import 'package:provider/provider.dart';
import 'package:shop_app/providers/products_provider.dart';

class ProductDetail extends StatelessWidget {
  static const routeName = "product detail";

  const ProductDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final prodId = ModalRoute.of(context)?.settings.arguments as String;
    final loadedProduct =
        Provider.of<Products>(context, listen: false).findByID(prodId);

    return Scaffold(
      appBar: AppBar(
        title: Text(loadedProduct.title),
      ),
      body: null,
    );
  }
}
