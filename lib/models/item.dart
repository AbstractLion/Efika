import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';

class Item {
  int id;
  String name;
  List<String> locationDescriptions = [];
  String imageUrl;
  int aisle;
  int shelfFromBottom;
  int shelfFromEnd;
  bool leftSide;
  String orientationDescription;
  Tuple3<int, int, int> dimensions;

  Item({
    @required this.id,
    @required this.name,
    this.locationDescriptions,
    @required this.imageUrl,
    this.aisle,
    this.shelfFromBottom,
    this.leftSide,
    this.orientationDescription,
    this.shelfFromEnd,
    this.dimensions,
  });
}
