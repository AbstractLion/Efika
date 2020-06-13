import 'package:efika/widgets/efika_app_bar.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: EfikaAppBar(
        title: Text('Profile'),
      ),
      body: Container(),
    );
  }
}
