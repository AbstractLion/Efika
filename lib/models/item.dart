import 'package:flutter/material.dart';

class Item {
  String name;
  List<String> descriptions = [];
  String imageUrl;
  int aisle;
  int shelfFromBottom;
  int shelfFromEnd;
  bool leftSide;
  String orientationDescription;

  Item(
      {@required this.name,
      this.descriptions,
      @required this.imageUrl,
      this.aisle,
      this.shelfFromBottom,
      this.leftSide,
      this.orientationDescription,
      this.shelfFromEnd});
}
