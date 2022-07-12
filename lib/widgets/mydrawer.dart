import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/screens/userproducts_screen.dart';

import '../providers/auth.dart';
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
          drawerChildPushReplacementNamed(
            context,
            Icons.shop,
            "Shop",
            "/",
          ),
          const Divider(),
          drawerChildPushReplacementNamed(
            context,
            Icons.payment,
            "Your Orders",
            OrdersScreen.routeName,
          ),
          const Divider(),
          drawerChildPushNamed(
            context,
            Icons.shopping_cart,
            "Your Cart",
            CartScreen.routeName,
          ),
          const Divider(),
          drawerChildPushNamed(
            context,
            Icons.edit,
            "User Products",
            UserProductsScreen.routeName,
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text("LogOut"),
            onTap: () {
              Navigator.of(context).pop();
              Provider.of<Auth>(context, listen: false).logout();
            },
          )
        ],
      ),
    );
  }

// todo //////////////////////////////////////////////////////////////

  ListTile drawerChildPushNamed(BuildContext context, IconData? icon,
      String title, String destinationRoute) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: () {
        Navigator.of(context).pushNamed(destinationRoute);
      },
    );
  }

  ListTile drawerChildPushReplacementNamed(BuildContext context, IconData? icon,
      String title, String destinationRoute) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: () {
        Navigator.of(context).pushReplacementNamed(destinationRoute);
      },
    );
  }
}
