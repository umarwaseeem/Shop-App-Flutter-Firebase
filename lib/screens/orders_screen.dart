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
  var _isLoading = false;

  @override
  void initState() {
    Future.delayed(Duration.zero).then((value) async {
      setState(() {
        _isLoading = true;
      });
      await Provider?.of<Orders>(context, listen: false).fetchAndSetOrder();
      setState(() {
        _isLoading = false;
      });
    });

    setState(() {
      _isLoading = true;
    });

    super.initState();
  }

  Future<void> _refresh(BuildContext context) async {
    await Provider.of<Orders>(context, listen: false).fetchAndSetOrder();
  }

  @override
  Widget build(BuildContext context) {
    final ordersData = Provider.of<Orders>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Added Orders")),
      body: RefreshIndicator(
        onRefresh: () => _refresh(context),
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: ordersData.orders.length,
                itemBuilder: (context, index) => AnOrderItem(
                  order: ordersData.orders[index],
                ),
              ),
      ),
      drawer: const MyDrawer(),
    );
  }
}
