import "package:flutter/material.dart";

import '../widgets/products_grid.dart';

enum FilterOptions {
  favourites,
  all,
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _showFavs = false;
  var title = "All Items";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: [
          PopupMenuButton(
            onSelected: displayDifferenceOnSelection,
            itemBuilder: makePopUpMenu,
            icon: const Icon(Icons.more_vert),
          ),
        ],
      ),
      body: ProductsGrid(showOnlyFav: _showFavs),
      drawer: const Drawer(),
    );
  }

  List<PopupMenuEntry<FilterOptions>> makePopUpMenu(_) {
    return [
      const PopupMenuItem(
        value: FilterOptions.favourites,
        child: Text("Only Favourites"),
      ),
      const PopupMenuItem(
        value: FilterOptions.all,
        child: Text("Show All"),
      ),
    ];
  }

  void displayDifferenceOnSelection(FilterOptions selectedValue) {
    setState(() {
      if (selectedValue == FilterOptions.favourites) {
        _showFavs = true;
        title = "Favourites";
      } else if (selectedValue == FilterOptions.all) {
        _showFavs = false;
        title = "All Items";
      }
    });
  }
}
