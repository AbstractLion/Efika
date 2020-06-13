import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class EfikaBottomNavigationBar extends StatelessWidget {
  final void Function(int) setPage;

  EfikaBottomNavigationBar({this.setPage});

  @override
  Widget build(BuildContext context) {
    return FancyBottomNavigation(
      tabs: [
        TabData(iconData: FontAwesomeIcons.box, title: "Orders"),
        TabData(iconData: FontAwesomeIcons.users, title: "Coworkers"),
        TabData(iconData: FontAwesomeIcons.userCircle, title: "Profile")
      ],
      onTabChangedListener: this.setPage,
    );
  }
}
