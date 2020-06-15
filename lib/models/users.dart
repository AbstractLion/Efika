import 'dart:convert';
import 'dart:math';

import 'package:efika/models/user.dart';
import 'package:flutter/services.dart';

class Users {
  static List<User> users = [];

  static Future<void> parseUsers() async {
    final jsonItems = await rootBundle.loadString('assets/users.txt');
    final usersList = json.decode(jsonItems);
    Random r = Random();

    usersList.forEach((user) {
      users.add(User(
        name: user['name'],
        avatarUrl: r.nextDouble() > 0.5 ? user['avatarUrl'] : null,
        fulfillments: r.nextInt(100) + 10,
        itemsSaved: r.nextInt(300) + 20,
      ));
    });
  }
}
