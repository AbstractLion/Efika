import 'package:efika/models/item.dart';
import 'package:efika/models/order.dart';
import 'package:efika/models/orders.dart';
import 'package:flutter/material.dart';
import 'package:getflutter/components/button/gf_button.dart';
import 'package:getflutter/components/button/gf_button_bar.dart';
import 'package:getflutter/components/card/gf_card.dart';
import 'package:getflutter/components/list_tile/gf_list_tile.dart';
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
    Order order = Orders.orders[routeParams.index];
    List<Item> items = order.items;
    return Scaffold(
      appBar: EfikaAppBar(
        title: Text('Order Items'),
      ),
      body: ListView.builder(
        itemCount: Orders.orders.length,
        itemBuilder: (BuildContext context, int index) {
          Item item = items[index];
          return GFCard(
            image: Image.network(item.imageUrl),
            title: GFListTile(
              title: Text(item.name),
            ),
            content: Column(
              children: <Widget>[
                Text("Aisle: ${item.aisle.toString()}"),
              ],
            ),
          );
        },
      ),
    );
  }
}
