import 'package:flutter/material.dart';

class User {
  String name;
  String avatarUrl;
  int fulfillments;
  int itemsSaved;

  User({
    @required this.name,
    this.avatarUrl,
    this.fulfillments,
    this.itemsSaved,
  });
}
