import 'package:flutter/cupertino.dart';
import "package:http/http.dart" as http;
import "dart:convert";

class Product with ChangeNotifier {
  final String? id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavourite;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
    this.isFavourite = false,
  });

  void _setFavValue(bool newValue) {
    isFavourite = newValue;
    notifyListeners();
  }

  Future<void> toggleFavStatus(String token, String userId) async {
    final oldStatus = isFavourite;
    isFavourite = !isFavourite;
    notifyListeners(); // notify that something changed and widget should rebuild

    final url = Uri.parse(
        "https://shopapp-24a6a-default-rtdb.firebaseio.com/userFavorites/$userId/$id.json?auth=$token");

    try {
      final response = await http.put(
        url,
        body: jsonEncode(
          {
            "isFavorite": isFavourite,
          },
        ),
      );

      if (response.statusCode >= 400) {
        _setFavValue(oldStatus);
      }
    } catch (error) {
      _setFavValue(oldStatus);

      rethrow;
    }
  }
}
