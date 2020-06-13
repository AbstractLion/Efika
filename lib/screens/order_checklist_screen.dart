import 'package:flutter/material.dart';

import '../widgets/efika_app_bar.dart';

class OrderChecklistScreen extends StatelessWidget {
  static const routeName = '/order_checklist';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: EfikaAppBar(
        title: Text('Orders'),
      ),
      body: Container(),
    );
  }
}
