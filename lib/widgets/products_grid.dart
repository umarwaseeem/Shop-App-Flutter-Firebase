import "package:flutter/material.dart";
import 'package:provider/provider.dart';
import 'package:shop_app/widgets/product_item.dart';
import '../providers/products_provider.dart';

class ProductsGrid extends StatelessWidget {
  final bool showOnlyFav;

  const ProductsGrid({Key? key, required this.showOnlyFav}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    final products = showOnlyFav ? productsData.favItems : productsData.items;

    for (var index = 0; index < products.length; index++) {
      showOnlyFav
          // ignore: avoid_print
          ? print("fav items ${products[index].title} ")
          // ignore: avoid_print
          : print("all ${products[index].title} ");
    }

    return GridView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: products.length,
      itemBuilder: (context, index) => ChangeNotifierProvider.value(
        // this approach when we are wrapping it on existing object
        value: products[index],
        child: const ProductItem(),
      ),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
        childAspectRatio: 1.5,
        mainAxisSpacing: 10,
      ),
    );
  }
}
