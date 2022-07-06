import "package:flutter/material.dart";

class ACartItem extends StatelessWidget {
  const ACartItem(
      {Key? key,
      required this.id,
      required this.price,
      required this.quantity,
      required this.title})
      : super(key: key);

  final String? id;
  final double price;
  final int quantity;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Card(
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
    );
  }
}
