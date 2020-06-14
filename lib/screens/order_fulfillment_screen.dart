import 'dart:math';

import 'package:efika/models/item.dart';
import 'package:efika/models/order.dart';
import 'package:efika/models/orders.dart';
import 'package:expandable_bottom_bar/expandable_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:getflutter/getflutter.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pie_chart/pie_chart.dart';

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

class ItemDetailView extends StatefulWidget {
  final Item item;
  ItemDetailView(this.item);

  @override
  State<StatefulWidget> createState() => _ItemDetailViewState();
}

class _ItemDetailViewState extends State<ItemDetailView> {
  bool isTrackingOn = false;

  @override
  Widget build(BuildContext context) {
    Map<String, double> compassMap = Map();
    compassMap.putIfAbsent('OtherPositions', () => 20);
    compassMap.putIfAbsent('ItemPosition', () => 1);

    return Column(
      children: [
        StreamBuilder<double>(
          stream: FlutterCompass.events,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.none &&
                snapshot.hasData == null) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            double direction = snapshot.data;

            if (direction == null) {
              return Center(
                child: Text('Device does not have sensors!'),
              );
            }

            return Column(
              children: [
                Stack(
                  children: [
                    PieChart(
                      dataMap: compassMap,
                      chartType: ChartType.ring,
                      showChartValueLabel: false,
                      showChartValues: false,
                      showChartValuesInPercentage: false,
                      showChartValuesOutside: false,
                      chartRadius: 200,
                      initialAngle: direction * pi / 180,
                      chartValueStyle: TextStyle(color: Colors.transparent),
                      colorList: [
                        Constants.backgroundColor.withOpacity(0.3),
                        Constants.accentColor,
                      ],
                      showLegends: false,
                    ),
                    Positioned.fill(
                      child: Center(
                        child: RawMaterialButton(
                          onPressed: () {
                            setState(() {
                              isTrackingOn = !isTrackingOn;
                            });
                          },
                          elevation: 8.0,
                          fillColor: isTrackingOn
                              ? Constants.backgroundColor
                              : Constants.backgroundColor.withOpacity(0.5),
                          child: Icon(
                            isTrackingOn
                                ? MdiIcons.compass
                                : MdiIcons.compassOff,
                            size: 30,
                          ),
                          padding: EdgeInsets.all(25.0),
                          shape: CircleBorder(),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ],
    );
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
  void initState() {
    super.initState();

    _fetchPermissionStatus();
  }

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

  void _fetchPermissionStatus() async {
    print(await Permission.locationWhenInUse.request());
    if (await Permission.locationWhenInUse.request().isGranted) {
      print('Permission locationWhenInUse granted.');
    }
  }
}
