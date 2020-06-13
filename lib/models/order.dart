import 'package:flutter/material.dart';

import 'item.dart';

class Order {
  List<Item> items = [];
  int id;
  DateTime dateOrdered;

  Order({@required this.id, this.items, @required this.dateOrdered});
}
