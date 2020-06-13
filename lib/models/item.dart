import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';

class Item {
  String name;
  List<String> descriptions = [];
  String imageUrl;
  int aisle;
  int shelfFromBottom;
  int shelfFromEnd;
  bool leftSide;
  String orientationDescription;
  Tuple3<int, int, int> dimensions;

  Item({
    @required this.name,
    this.descriptions,
    @required this.imageUrl,
    this.aisle,
    this.shelfFromBottom,
    this.leftSide,
    this.orientationDescription,
    this.shelfFromEnd,
    this.dimensions,
  });
}
