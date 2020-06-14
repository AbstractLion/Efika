import 'dart:convert';

import 'package:efika/models/user.dart';
import 'package:flutter/services.dart';

class Users {
  static List<User> users = [];

  static Future<void> parseUsers() async {
    final jsonItems = await rootBundle.loadString('assets/users.txt');
    final usersList = json.decode(jsonItems);

    usersList.forEach((user) {
      users.add(User(
        name: user['name'],
        avatarUrl: user['avatarUrl'],
      ));
    });
  }
}
