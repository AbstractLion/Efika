import 'package:flutter/material.dart';
import '../widgets/efika_app_bar.dart';

class RouteParams {
  final int index;
  RouteParams(this.index);
}

class OrderFulfillmentScreen extends StatelessWidget {
  static const routeName = '/order_fulfillment';
  @override
  Widget build(BuildContext context) {
    final RouteParams routeParams = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: EfikaAppBar(
        title: Text('Order Items'),
      ),
      body: Text(
        routeParams.index.toString(),
      ),
    );
  }
}
