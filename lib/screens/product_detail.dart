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
        Provider.of<Products>(context, listen: false).findById(prodId);

    return Scaffold(
      // appBar: AppBar(
      //   title: Text(loadedProduct.title),
      // ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                loadedProduct.title,
                style: const TextStyle(color: Colors.black),
              ),
              background: Hero(
                tag: loadedProduct.id!,
                child: Image.network(loadedProduct.imageUrl, fit: BoxFit.cover),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                const SizedBox(height: 20),
                SizedBox(
                  height: 30,
                  width: double.infinity,
                  child: Text(
                    loadedProduct.price.toString(),
                    style: const TextStyle(fontSize: 20, color: Colors.grey),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    loadedProduct.description,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 15),
                  ),
                ),
                const SizedBox(height: 800),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
