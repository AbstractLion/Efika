import 'dart:math';

import 'package:efika/models/item.dart';
import 'package:efika/models/items.dart';
import 'package:efika/models/users.dart';

import 'order.dart';

class Orders {
  static final List<Order> orders = [];

  static const int numOrders = 20;
  static const int maxItems = 20;

  static void generateOrders() {
    final randomDates = [];
    final randomItems = [];

    DateTime today = DateTime.now();
    final Random r = Random();
    for (int i = 0; i < numOrders; ++i) {
      randomDates.add(today.subtract(Duration(minutes: r.nextInt(7200) + 1)));
      List<Item> currentItems = [];
      for (int j = 2; j <= maxItems; ++j) {
        currentItems.add(Items.items[r.nextInt(Items.items.length)]);
      }
      randomItems.add(currentItems);
    }
    randomDates.sort();

    final int startId = r.nextInt(1000000) + 100000;
    for (int i = 0; i < numOrders; ++i) {
      orders.add(Order(
        id: startId - i * 100 - r.nextInt(100),
        dateOrdered: randomDates[i],
        items: randomItems[i],
        orderer: Users.users[r.nextInt(Users.users.length)],
      ));
    }
  }
}
