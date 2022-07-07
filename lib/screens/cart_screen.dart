import "package:flutter/material.dart";
import 'package:provider/provider.dart';

import '../providers/cart.dart';
import '../providers/orders.dart';
import '../widgets/cart_item.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  static const routeName = "cart screen";

  @override
  Widget build(BuildContext context) {
    var cartData = Provider.of<Cart>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Your Cart")),
      body: Column(
        children: [
          Card(
            margin: const EdgeInsets.all(10),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Total", style: TextStyle(fontSize: 20)),
                  const Spacer(),
                  Chip(
                    label: Text(
                      cartData.totalPrice.toString(), // text value
                      style: TextStyle(
                        color:
                            Theme.of(context).primaryTextTheme.headline6?.color,
                      ),
                    ),
                    backgroundColor: Colors.orange,
                  ),
                  const SizedBox(width: 10),
                  TextButton(
                      onPressed: () {
                        if (cartData.totalPrice == 0) {
                          return;
                        }
                        Provider.of<Orders>(context, listen: false).addOrder(
                          cartData.items.values.toList(),
                          cartData.totalPrice,
                        );
                        cartData.clear();
                      },
                      child: const Text("ORDER NOW"))
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: cartData.itemCount,
              itemBuilder: (context, index) {
                return ACartItem(
                  prodId: cartData.items.keys.toList()[index],
                  id: cartData.items.values.toList()[index].id,
                  price: cartData.items.values.toList()[index].price,
                  quantity: cartData.items.values.toList()[index].quantity,
                  title: cartData.items.values.toList()[index].title,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
