import 'package:flutter/material.dart';

import '../widgets/efika_app_bar.dart';

class OrderFulfillmentScreen extends StatelessWidget {
  static const routeName = '/order_fulfillment';

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
