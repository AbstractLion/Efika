import 'dart:convert';
import 'dart:math';

import 'package:flutter/services.dart';
import 'package:tuple/tuple.dart';

import 'item.dart';

class Items {
  static List<Item> items = [];

  static Future<void> parseInformation() async {
    final jsonItems = await rootBundle.loadString('assets/items.txt');
    final itemsList = json.decode(jsonItems);

    Random r = Random();
    itemsList.forEach((item) {
      try {
        items.add(Item(
          id: r.nextInt(9999999),
          name: item['name'],
          imageUrl: item['imageUrl'],
          aisle: r.nextInt(13) + 1,
          shelfFromBottom: r.nextInt(3) + 1,
          shelfFromEnd: r.nextInt(5) + 1,
          leftSide: r.nextDouble() > 0.5,
          dimensions: Tuple3<int, int, int>(
            r.nextInt(5) + 1,
            r.nextInt(10) + 1,
            r.nextInt(20) + 1,
          ),
        ));
      } catch (e) {
        print('Error');
      }
    });
  }

  static Item getItemByIndex(int index) {
    return items[index];
  }

  /*
  String name;
  List<String> descriptions = [];
  String imageUrl;
  int aisle;
  int shelfFromBottom;
  int shelfFromEnd;
  bool leftSide;
  String orientationDescription;
  Tuple3<int, int, int> dimensions;
   */
}
