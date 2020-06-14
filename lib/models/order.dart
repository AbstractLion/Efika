import 'package:efika/models/user.dart';
import 'package:flutter/material.dart';

import 'item.dart';

class Order {
  List<Item> items = [];
  int id;
  DateTime dateOrdered;
  User orderer;

  Order({
    @required this.id,
    this.items,
    @required this.dateOrdered,
    @required this.orderer,
  });
}
