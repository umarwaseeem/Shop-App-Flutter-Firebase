import "package:flutter/material.dart";
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/products_provider.dart';
import 'package:shop_app/widgets/user_product.dart';

import 'edit_product_screen.dart';

class UserProductsScreen extends StatelessWidget {
  const UserProductsScreen({Key? key}) : super(key: key);

  static const routeName = "user products screen";

  Future<void> _refresh(BuildContext context) async {
    await Provider.of<Products>(context, listen: false).fetchAndSet(true);
  }

  @override
  Widget build(BuildContext context) {
    // final productsData = Provider.of<Products>(context);
    print("helllo");
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Products"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(EditProductScreen.routeName);
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: FutureBuilder(
        future: _refresh(context),
        builder: (context, snapShot) =>
            snapShot.connectionState == ConnectionState.waiting
                ? Center(
                    child: LoadingAnimationWidget.staggeredDotsWave(
                        color: Colors.black, size: 40),
                  )
                : RefreshIndicator(
                    onRefresh: () => _refresh(context),
                    child: Consumer<Products>(
                      builder: (context, productsData, child) => Padding(
                        padding: const EdgeInsets.all(10),
                        child: ListView.builder(
                          itemCount: productsData.items.length,
                          itemBuilder: (_, i) => Column(
                            children: [
                              UserProductItem(
                                price: productsData.items[i].price.toString(),
                                description: productsData.items[i].description,
                                id: productsData.items[i].id.toString(),
                                title: productsData.items[i].title,
                                imageUrl: productsData.items[i].imageUrl,
                              ),
                              const Divider(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
      ),
    );
  }
}
