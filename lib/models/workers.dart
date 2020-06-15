import 'package:efika/models/users.dart';
import 'package:flutter/material.dart';
import 'package:search_app_bar/searcher.dart';

import 'user.dart';

class Workers with ChangeNotifier implements Searcher<User> {
  static List<User> workers = [
    User(
      name: 'Dragon He',
      avatarUrl:
          'https://media-exp1.licdn.com/dms/image/C4D03AQEyzcJ9UyrGtA/profile-displayphoto-shrink_200_200/0?e=1597276800&v=beta&t=n0_a6sYJQuYiyCQ8Aa3XhqPSLZWOPn6IZPJXqawjhYQ',
      itemsSaved: 43,
      fulfillments: 12,
    ),
    User(
      name: 'Avaneesh Kulkarni',
      itemsSaved: 412,
      fulfillments: 74,
    ),
    User(
      name: 'Kevin Wang',
      itemsSaved: 52,
      fulfillments: 14,
    ),
    ...Users.users.skip(30)
  ];

  List<User> filteredWorkers;

  Workers() {
    filteredWorkers = []..addAll(workers);
  }

  @override
  List<User> get data => workers;

  @override
  Function(List<User> p1) get onDataFiltered => _filterWorkers;

  dynamic _filterWorkers(List<dynamic> workersList) {
    filteredWorkers = workersList as List<User>;
    notifyListeners();
  }
}
