import "package:flutter/material.dart";
import 'package:provider/provider.dart';
import 'package:shop_app/screens/product_detail.dart';

import '../providers/product.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(
      context,
      listen: false,
    ); // whole build will run when something changes, consumer way when some sub part runs again
    return Consumer<Product>(
      builder: (BuildContext context, value, Widget? child) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: GridTile(
            footer: GridTileBar(
              backgroundColor: Colors.black54,
              title: Text(
                product.title,
                textAlign: TextAlign.center,
              ),
              leading: togglingFavs(product),
              trailing: Consumer<Product>(
                builder: (BuildContext context, value, Widget? child) {
                  return IconButton(
                    color: Colors.red,
                    onPressed: () {},
                    icon: const Icon(Icons.shopping_cart_outlined),
                  );
                },
              ),
            ),
            child: imageToItsDetails(context, product),
          ),
        );
      },
    );
  }

  Consumer<Product> togglingFavs(Product product) {
    return Consumer<Product>(
      // only this will rerun when something changes
      // child is something that will remain same every time for the widget wrapped in consumer
      builder: (BuildContext context, value, Widget? child) {
        return IconButton(
          color: Colors.red,
          onPressed: () {
            product.toggleFavStatus();
          },
          icon: Icon(
            product.isFavourite
                ? Icons.favorite
                : Icons.favorite_border_outlined,
          ),
        );
      },
    );
  }

  GestureDetector imageToItsDetails(BuildContext context, Product product) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(
          ProductDetail.routeName,
          arguments: product.id,
        );
      },
      child: Image.network(
        product.imageUrl,
        fit: BoxFit.cover,
      ),
    );
  }
}
