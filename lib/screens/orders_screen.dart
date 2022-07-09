import "package:flutter/material.dart";
import 'package:provider/provider.dart';
import 'package:shop_app/widgets/mydrawer.dart';

import "../providers/orders.dart";
import "../widgets/order_item.dart";

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({Key? key}) : super(key: key);

  static const routeName = "orders screen";

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  Future<void> _refresh(BuildContext context) async {
    await Provider.of<Orders>(context, listen: false).fetchAndSetOrder();
  }

  @override
  Widget build(BuildContext context) {
    // final ordersData = Provider.of<Orders>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Added Orders")),
      body: RefreshIndicator(
        onRefresh: () => _refresh(context),
        child: FutureBuilder(
          future:
              Provider.of<Orders>(context, listen: false).fetchAndSetOrder(),
          builder: (context, dataSnapshot) {
            if (dataSnapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (dataSnapshot.error != null) {
              return const Center(child: Text("An error occured"));
            } else {
              return Consumer<Orders>(
                builder: (context, ordersData, child) {
                  return ListView.builder(
                    itemCount: ordersData.orders.length,
                    itemBuilder: (context, index) => AnOrderItem(
                      order: ordersData.orders[index],
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
      drawer: const MyDrawer(),
    );
  }
}
