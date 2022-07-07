import "package:flutter/material.dart";
import 'package:intl/intl.dart';
import "dart:math";

import "../providers/orders.dart";

class AnOrderItem extends StatefulWidget {
  const AnOrderItem({Key? key, required this.order}) : super(key: key);

  final OrderItem order;

  @override
  State<AnOrderItem> createState() => _AnOrderItemState();
}

class _AnOrderItemState extends State<AnOrderItem> {
  var _expanded = true;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.orange,
      margin: const EdgeInsets.all(10),
      child: Column(
        children: [
          ListTile(
            title: Text(
              widget.order.amount.toString(),
            ),
            subtitle: Text(
              DateFormat("dd/MM/yyyy hh::mm").format(widget.order.dateTime),
            ),
            trailing: IconButton(
              onPressed: () {
                setState(() {
                  _expanded = !_expanded;
                });
              },
              icon: Icon(_expanded ? Icons.expand_less : Icons.expand_more),
            ),
          ),
          if (_expanded)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
              color: Colors.black26,
              height: min(widget.order.orderProducts.length * 20.0 + 20, 180),
              child: ListView(
                children: widget.order.orderProducts
                    .map(
                      (prod) => Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            prod.title,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "${prod.quantity}x \$${prod.price}",
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                            ),
                          )
                        ],
                      ),
                    )
                    .toList(),
              ),
            )
        ],
      ),
    );
  }
}
