import 'package:flutter/material.dart';
import 'package:search_app_bar/searcher.dart';

import 'order.dart';

class Orders with ChangeNotifier implements Searcher<Order> {
  List<Order> _filteredOrders = List<Order>();
  List<Order> get filteredOrders => _filteredOrders;

  final List<Order> orders = [];

  Orders() {
    _filteredOrders = orders;
  }

  void addOrder(Order order) {
    orders.add(order);
  }

  @override
  get data => orders;

  @override
  Function(List<Order>) get onDataFiltered => (List<Order> orders) {
        _filteredOrders = orders;
        notifyListeners();
      };
}
