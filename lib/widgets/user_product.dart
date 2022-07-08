import "package:flutter/material.dart";
import 'package:provider/provider.dart';

import '../providers/products_provider.dart';
import '../screens/edit_product_screen.dart';

class UserProductItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;
  final String description;
  final String price;

  const UserProductItem(
      {Key? key,
      required this.title,
      required this.imageUrl,
      required this.id,
      required this.description,
      required this.price})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context, listen: false);

    return Material(
      elevation: 10,
      type: MaterialType.card,
      shadowColor: Colors.grey,
      child: ListTile(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title),
            Text(price, style: const TextStyle(fontSize: 14)),
          ],
        ),
        subtitle: Text(description),
        leading: CircleAvatar(
          backgroundImage: NetworkImage(imageUrl),
        ),
        trailing: SizedBox(
          width: 100,
          child: Row(
            children: [
              // Text(price),
              IconButton(
                onPressed: () {
                  productsData.deleteProduct(id);
                },
                icon: const Icon(Icons.delete),
                color: Theme.of(context).errorColor,
              ),
              IconButton(
                onPressed: () {
                  Navigator.of(context)
                      .pushNamed(EditProductScreen.routeName, arguments: id);
                },
                icon: const Icon(Icons.edit),
                color: Theme.of(context).primaryColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
