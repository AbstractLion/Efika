import 'package:flutter/material.dart';

class EfikaAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget title;

  EfikaAppBar({@required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(title: title);
  }

  @override
  Size get preferredSize => Size.fromHeight(56);
}
