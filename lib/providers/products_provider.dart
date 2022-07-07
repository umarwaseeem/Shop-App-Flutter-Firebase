import 'package:flutter/widgets.dart';

import 'product.dart';

class Products with ChangeNotifier {
  final List<Product> _items = [
    Product(
      id: 'p1',
      title: 'Red Shirt',
      description: 'A red shirt - it is pretty red!',
      price: 29.99,
      imageUrl:
          'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    ),
    Product(
      id: 'p2',
      title: 'Trousers',
      description: 'A nice pair of trousers.',
      price: 59.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    ),
    Product(
      id: 'p3',
      title: 'Yellow Scarf',
      description: 'Warm and cozy - exactly what you need for the winter.',
      price: 19.99,
      imageUrl:
          'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    ),
    Product(
      id: 'p4',
      title: 'A Pan',
      description: 'Prepare any meal you want.',
      price: 49.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    ),
  ];

  // var _showFavsOnly = false;

  List<Product> get items {
    // if (_showFavsOnly) {
    //   return _items.where((prod) => prod.isFavourite).toList();
    // } else {
    return [..._items]; // copy of items returned, spread operator
  }

  // void showFavsOnly() {
  //   _showFavsOnly = true;
  //   notifyListeners();
  // }

  List<Product> get favItems {
    return _items.where((prod) => prod.isFavourite).toList();
  }

  // void showAll() {
  //   _showFavsOnly = false;
  //   notifyListeners();
  // }

  // void addProduct(/*value*/) {
  // _items.add(value);
  //   notifyListeners();
  // }

  Product findByID(String id) {
    return _items.firstWhere((prod) => prod.id == id);
  }

  void addProduct(Product product) {
    final newProduct = Product(
      imageUrl: product.imageUrl,
      title: product.title,
      description: product.description,
      price: product.price,
      id: DateTime.now().toString(),
    );

    _items.add(newProduct);

    notifyListeners();
  }

  void updateProduct(String id, Product product) {
    final index = _items.indexWhere((element) => element.id == id);

    if (index >= 0) {
      _items[index] = product;
      notifyListeners();
    }
  }

  void deleteProduct(String id) {
    _items.removeWhere((element) => element.id == id);
    notifyListeners();
  }
}
