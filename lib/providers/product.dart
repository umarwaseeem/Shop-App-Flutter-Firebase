import 'package:flutter/cupertino.dart';

class Product with ChangeNotifier {
  late final String id;
  late final String title;
  late final String description;
  late final double price;
  late final String imageUrl;
  late bool isFavourite;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
    this.isFavourite = false,
  });

  void toggleFavStatus() {
    isFavourite = !isFavourite;
    notifyListeners(); // notify that something changed and widget should rebuild
  }
}
