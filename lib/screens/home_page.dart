import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products_provider.dart';
import '../widgets/mydrawer.dart';
import '../widgets/products_grid.dart';
import '../widgets/badge.dart';
import '../providers/cart.dart';
import './cart_screen.dart';

enum FilterOptions {
  Favorites,
  All,
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  var _showOnlyFavorites = false;

  var _isInit = true;

  var _isLoading = false;

  // @override
  // void initState() {
  //   // Provider.of<Products>(context, listen: false).fetchAndSet();

  //   // Future.delayed(Duration.zero).then((_) {
  //   //   Provider.of<Products>(context).fetchAndSet();
  //   // });

  //   super.initState();
  // }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      _isLoading = true;
      Provider.of<Products>(context).fetchAndSet().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }

    _isInit = false;

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MyShop'),
        actions: <Widget>[
          PopupMenuButton(
            onSelected: (FilterOptions selectedValue) {
              setState(() {
                if (selectedValue == FilterOptions.Favorites) {
                  _showOnlyFavorites = true;
                } else {
                  _showOnlyFavorites = false;
                }
              });
            },
            icon: const Icon(
              Icons.more_vert,
            ),
            itemBuilder: (_) => [
              const PopupMenuItem(
                value: FilterOptions.Favorites,
                child: Text('Only Favorites'),
              ),
              const PopupMenuItem(
                value: FilterOptions.All,
                child: Text('Show All'),
              ),
            ],
          ),
          Consumer<Cart>(
            builder: (_, cart, ch) => Badge(
              value: cart.itemCount.toString(),
              child: ch!,
            ),
            child: IconButton(
              icon: const Icon(
                Icons.shopping_cart,
              ),
              onPressed: () {
                Navigator.of(context).pushNamed(CartScreen.routeName);
              },
            ),
          ),
        ],
      ),
      drawer: const MyDrawer(),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ProductsGrid(showFavs: _showOnlyFavorites),
    );
  }
}
