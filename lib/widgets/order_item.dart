import "package:flutter/material.dart";
import 'package:intl/intl.dart';

import "../providers/orders.dart";

class AnOrderItem extends StatelessWidget {
  const AnOrderItem({Key? key, required this.order}) : super(key: key);

  final OrderItem order;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: Column(
        children: [
          ListTile(
            title: Text(
              order.amount.toString(),
            ),
            subtitle: Text(
              DateFormat("dd/MM/yyyy hh::mm").format(order.dateTime),
            ),
            trailing: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.expand_circle_down),
            ),
          ),
        ],
      ),
    );
  }
}
