import "package:flutter/material.dart";
import 'package:shop_app/providers/cart.dart';

class OrderItem with ChangeNotifier {
  final String id;
  final double amount;
  final List<CartItem> orderProducts;
  final DateTime dateTime;

  OrderItem({
    required this.id,
    required this.amount,
    required this.orderProducts,
    required this.dateTime,
  });
}

class Orders with ChangeNotifier {
  final List<OrderItem> _orders = [];

  List<OrderItem> get orders {
    return [..._orders];
  }

  void addOrder(List<CartItem> cartProducts, double total) {
    _orders.insert(
      0,
      OrderItem(
        id: DateTime.now().toString(),
        amount: total,
        dateTime: DateTime.now(),
        orderProducts: cartProducts,
      ),
    );
    notifyListeners();
  }
}
