import 'package:flutter/material.dart';

import '../screens/cart_screen.dart';
import '../screens/orders_screen.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            title: const Text('Hello Friend!'),
            automaticallyImplyLeading: false,
          ),
          const Divider(),
          drawerChild(context, Icons.shop, "Shop", "/"),
          const Divider(),
          drawerChild(
              context, Icons.payment, "Your Orders", OrdersScreen.routeName),
          const Divider(),
          drawerChildCartScreen(context),
        ],
      ),
    );
  }

// todo //////////////////////////////////////////////////////////////

  ListTile drawerChildCartScreen(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.shopping_cart),
      title: const Text('Your Cart'),
      onTap: () {
        Navigator.pop(context);
        Navigator.of(context).pushNamed("/");
        Navigator.of(context).pushNamed(CartScreen.routeName);
      },
    );
  }

  ListTile drawerChild(BuildContext context, IconData? icon, String title,
      String destinationRoute) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: () {
        Navigator.of(context).pushReplacementNamed(destinationRoute);
      },
    );
  }
}
