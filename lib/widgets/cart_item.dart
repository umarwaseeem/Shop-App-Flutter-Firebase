import "package:flutter/material.dart";
import 'package:provider/provider.dart';
import 'package:shop_app/providers/cart.dart';

class ACartItem extends StatelessWidget {
  const ACartItem(
      {Key? key,
      required this.id,
      required this.price,
      required this.quantity,
      required this.title,
      this.prodId})
      : super(key: key);

  final String? id;
  final String? prodId;
  final double price;
  final int quantity;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      direction: DismissDirection.endToStart,
      key: ValueKey(id),
      background: Container(
        color: Colors.red,
        child: Container(
          color: Colors.red,
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.only(right: 20),
          margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 15),
          child: const Icon(Icons.delete_sweep),
        ),
      ),
      onDismissed: (direction) {
        Provider.of<Cart>(context, listen: false).removeItem(prodId);
      },
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 15),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.orange,
              child: FittedBox(
                child: Text(
                  price.toString(),
                  style: const TextStyle(color: Colors.white, fontSize: 14),
                ),
              ),
            ),
            title: Text(title.toString()),
            subtitle: Text("Total: ${price * quantity}"),
            trailing: Text("${quantity}x"),
          ),
        ),
      ),
    );
  }
}
