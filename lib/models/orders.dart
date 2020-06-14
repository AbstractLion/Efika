import 'dart:math';

import 'package:efika/models/item.dart';
import 'package:efika/models/items.dart';
import 'package:efika/models/users.dart';
import 'package:tuple/tuple.dart';

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
      randomItems.add(List<Item>()
        ..add(Item(
          id: r.nextInt(9999999),
          name: 'Nestlé Multigrain Cheerios',
          imageUrl:
              'https://www.nestle-cereals.com/uk/sites/g/files/qirczx211/f/styles/mobile_752x432/public/product_gallery/cheerios_multigrain_820x1094_0.png?itok=SWjKqlW8',
          aisle: r.nextInt(13) + 1,
          shelfFromBottom: r.nextInt(3) + 1,
          shelfFromEnd: r.nextInt(5) + 1,
          leftSide: r.nextDouble() > 0.5,
          dimensions: Tuple3<int, int, int>(
            r.nextInt(5) + 1,
            r.nextInt(10) + 1,
            r.nextInt(20) + 1,
          ),
          locationImages: [
            'https://i.ibb.co/h1VddtK/image.jpg',
            'https://c8.alamy.com/comp/HWEF2J/breakfast-cereal-for-sale-in-a-morrisons-supermarket-HWEF2J.jpg',
          ],
        ))
        ..addAll(currentItems));
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
