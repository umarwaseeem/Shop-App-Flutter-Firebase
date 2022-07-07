import "package:flutter/material.dart";
import 'package:provider/provider.dart';
import 'package:shop_app/widgets/mydrawer.dart';

import "../providers/orders.dart";
import "../widgets/order_item.dart";

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({Key? key}) : super(key: key);

  static const routeName = "orders screen";

  @override
  Widget build(BuildContext context) {
    final ordersData = Provider.of<Orders>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Added Orders")),
      body: ListView.builder(
        itemCount: ordersData.orders.length,
        itemBuilder: (context, index) => AnOrderItem(
            order: ordersData.orders[index],
          ),
      ),
      drawer: const MyDrawer(),
    );
  }
}
