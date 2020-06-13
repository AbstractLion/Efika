import 'package:flutter/material.dart';

import '../widgets/bottom_navigation.dart';
import 'orders.dart';

class HomeNavigation extends StatefulWidget {
  static const routeName = '/home';

  @override
  State<StatefulWidget> createState() => _HomeNavigationState();
}

class _HomeNavigationState extends State<HomeNavigation> {
  int _currentPage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: _getPage(),
      bottomNavigationBar: BottomNavigation(
        setPage: (index) {
          setState(() {
            this._currentPage = index;
          });
        },
      ),
    );
  }

  Widget _getPage() {
    switch (this._currentPage) {
      case 0:
        return OrdersScreen();
    }
    return OrdersScreen();
  }
}
