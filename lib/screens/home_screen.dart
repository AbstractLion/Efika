import 'package:efika/models/workers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/efika_bottom_navigation_bar.dart';
import 'coworkers_screen.dart';
import 'orders_screen.dart';
import 'profile_screen.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home';

  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static Workers workerChangeNotifier = Workers();

  final List<Widget> tabs = [
    OrdersScreen(),
    ChangeNotifierProvider.value(
      value: workerChangeNotifier,
      child: CoworkersScreen(),
    ),
    ProfileScreen(),
  ];

  int _currentTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: workerChangeNotifier,
      child: Scaffold(
        body: SafeArea(
          top: false,
          child: IndexedStack(
            index: _currentTabIndex,
            children: tabs,
          ),
        ),
        bottomNavigationBar: EfikaBottomNavigationBar(
          setPage: (index) {
            setState(() {
              this._currentTabIndex = index;
            });
          },
        ),
      ),
    );
  }
}
