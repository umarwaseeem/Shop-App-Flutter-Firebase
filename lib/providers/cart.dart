import "package:flutter/material.dart";

class CartItem {
  final String title;
  final String id;
  final int quantity;
  final double price;

  CartItem({
    required this.title,
    required this.id,
    required this.quantity,
    required this.price,
  });
}

class Cart with ChangeNotifier {
  final Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  void addItems(String title, String id, int quantity, double price) {
    if (_items.containsKey(id)) {
      // increase quantity
      _items.update(
        id,
        (existingItem) => CartItem(
            title: existingItem.title,
            price: existingItem.price,
            id: existingItem.id,
            quantity: existingItem.quantity + 1),
      );
    } else {
      _items.putIfAbsent(
        id,
        () => CartItem(
          id: DateTime.now().toString(),
          quantity: 1,
          title: title,
          price: price,
        ),
      );
    }
  }
}
