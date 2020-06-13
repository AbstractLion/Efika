import 'package:flutter/material.dart';

import 'item.dart';

class Order {
  List<Item> items = [];
  int id;

  Order({@required this.id, this.items});
}
