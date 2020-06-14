import 'package:efika/models/item.dart';
import 'package:efika/models/order.dart';
import 'package:efika/models/orders.dart';
import 'package:expandable_bottom_bar/expandable_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:getflutter/getflutter.dart';

import '../constants.dart';
import '../widgets/efika_app_bar.dart';

class RouteParams {
  final int index;
  RouteParams(this.index);
}

class OrderFulfillmentScreen extends StatefulWidget {
  static const routeName = '/order_fulfillment';

  @override
  State<StatefulWidget> createState() => _OrderFulfillmentScreenState();
}

class _OrderFulfillmentScreenState extends State<OrderFulfillmentScreen> {
  int currentItemIndex = 0;

  @override
  Widget build(BuildContext context) {
    final RouteParams routeParams = ModalRoute.of(context).settings.arguments;
    Order order = Orders.orders[routeParams.index];
    return Scaffold(
      appBar: EfikaAppBar(
        title: Text('Order Items'),
      ),
      body: ItemDetailView(order.items[currentItemIndex]),
      // Lets use docked FAB for handling state of sheet
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: GestureDetector(
        // Set onVerticalDrag event to drag handlers of controller for swipe effect
        onVerticalDragUpdate: DefaultBottomBarController.of(context).onDrag,
        onVerticalDragEnd: DefaultBottomBarController.of(context).onDragEnd,
        child: FloatingActionButton.extended(
          label: Text('Items'),
          elevation: 2,
          backgroundColor: Constants.accentColor,
          foregroundColor: Colors.white,
          onPressed: () => DefaultBottomBarController.of(context).swap(),
        ),
      ),
      bottomNavigationBar: BottomExpandableAppBar(
        expandedHeight: 500,
        horizontalMargin: 16,
        shape: AutomaticNotchedShape(
            RoundedRectangleBorder(), StadiumBorder(side: BorderSide())),
        expandedBackColor: Colors.white,
        expandedBody: ItemsListView(order),
        bottomAppBarColor: Constants.backgroundColor,
        bottomAppBarBody: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Expanded(
                child: Text(
                  "Tets",
                  textAlign: TextAlign.center,
                ),
              ),
              Spacer(
                flex: 2,
              ),
              Expanded(
                child: Text(
                  "Stet",
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ItemDetailView extends StatelessWidget {
  final Item item;

  ItemDetailView(this.item);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class ItemsListView extends StatefulWidget {
  final Order order;

  ItemsListView(this.order);

  @override
  State<StatefulWidget> createState() => _ItemsListViewState();
}

class _ItemsListViewState extends State<ItemsListView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 3,
            blurRadius: 2,
          ),
        ],
      ),
      child: ListView.builder(
        itemCount: widget.order.items.length,
        itemBuilder: (BuildContext context, int index) {
          Item item = widget.order.items[index];
          return GFListTile(
            avatar: Image.network(
              item.imageUrl,
              fit: BoxFit.contain,
              height: 50,
              width: 50,
            ),
            title: Row(
              children: [
                Text(item.name),
              ],
            ),
          );
        },
      ),
    );
  }
}
