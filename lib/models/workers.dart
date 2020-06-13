import 'package:flutter/material.dart';
import 'package:search_app_bar/searcher.dart';

import 'worker.dart';

class Workers with ChangeNotifier implements Searcher<Worker> {
  static List<Worker> workers = [
    Worker(name: 'Leon Si'),
    Worker(
      name: 'Dragon He',
      avatarUrl:
          'https://media-exp1.licdn.com/dms/image/C4D03AQEyzcJ9UyrGtA/profile-displayphoto-shrink_200_200/0?e=1597276800&v=beta&t=n0_a6sYJQuYiyCQ8Aa3XhqPSLZWOPn6IZPJXqawjhYQ',
    ),
    Worker(name: 'Avaneesh Kulkarni'),
    Worker(name: 'Kevin Wang'),
  ];

  List<Worker> filteredWorkers;

  Workers() {
    filteredWorkers = []..addAll(workers);
  }

  @override
  // TODO: implement data
  List<Worker> get data => workers;

  @override
  // TODO: implement onDataFiltered
  Function(List<Worker> p1) get onDataFiltered => _filterWorkers;

  dynamic _filterWorkers(List<dynamic> workersList) {
    filteredWorkers = workersList as List<Worker>;
    notifyListeners();
  }
}
