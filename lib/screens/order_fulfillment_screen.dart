import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:efika/models/item.dart';
import 'package:efika/models/order.dart';
import 'package:efika/models/orders.dart';
import 'package:efika/screens/order_fulfillment_save_item_screen.dart';
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
          elevation: 20,
          backgroundColor: Constants.backgroundColor,
          foregroundColor: Colors.white,
          onPressed: () => DefaultBottomBarController.of(context).swap(),
        ),
      ),
      bottomNavigationBar: BottomExpandableAppBar(
        expandedHeight: 500,
        horizontalMargin: 16,
        shape: AutomaticNotchedShape(
          RoundedRectangleBorder(),
          StadiumBorder(side: BorderSide()),
        ),
        expandedBackColor: Colors.white,
        expandedBody: ItemsListView(order, setCurrentItemIndex: (index) {
          setState(() {
            currentItemIndex = index;
          });
        }),
        bottomAppBarColor: Constants.backgroundColor,
        bottomAppBarBody: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Expanded(
                child: GFButton(
                  text: 'Out of Stock?',
                  color: GFColors.DANGER,
                  onPressed: () {},
                ),
              ),
              Spacer(
                flex: 2,
              ),
              Expanded(
                child: GFButton(
                  text: 'Check Off',
                  color: Constants.accentColor,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => OrderFulfillmentSaveItemScreen(
                          itemIndex: currentItemIndex,
                          setItemIndex: (index) {
                            setState(() {
                              this.currentItemIndex = index;
                            });
                          },
                        ),
                      ),
                    );
                  },
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
  bool isCompassOn = false;

  @override
  Widget build(BuildContext context) {
    final curImgList = []..addAll(widget.item.locationImages);
    curImgList.insert(0, widget.item.imageUrl);
    final List<Widget> imageSliders = curImgList
        .map(
          (item) => Container(
            child: Container(
              margin: EdgeInsets.all(5.0),
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                child: Stack(
                  children: <Widget>[
                    Image.network(item, fit: BoxFit.cover, width: 1000.0),
                    Positioned(
                      bottom: 0.0,
                      left: 0.0,
                      right: 0.0,
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Color.fromARGB(100, 0, 0, 0),
                              Color.fromARGB(0, 0, 0, 0)
                            ],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                          ),
                        ),
                        padding: EdgeInsets.symmetric(
                          vertical: 10.0,
                          horizontal: 20.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        )
        .toList();

    Map<String, double> compassMap = Map();
    compassMap.putIfAbsent('OtherPositions', () => 20);
    if (isCompassOn) compassMap.putIfAbsent('ItemPosition', () => 1);

    return Wrap(
      children: [
        Column(
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

                final List<Color> compassColorList = [
                  Constants.backgroundColor
                      .withOpacity(isCompassOn ? 0.3 : 0.15),
                ];

                if (isCompassOn) compassColorList.add(Constants.accentColor);

                return Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: Text(
                        widget.item.name,
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    _buildLabelText('Aisle #: ', widget.item.aisle.toString()),
                    Padding(
                      padding: EdgeInsets.only(bottom: 15),
                      child: Stack(
                        children: [
                          PieChart(
                            dataMap: compassMap,
                            chartType: ChartType.ring,
                            showChartValueLabel: false,
                            showChartValues: false,
                            showChartValuesInPercentage: false,
                            showChartValuesOutside: false,
                            chartRadius: 150,
                            initialAngle: -direction * pi / 180 +
                                widget.item.bearingOffset,
                            chartValueStyle:
                                TextStyle(color: Colors.transparent),
                            colorList: compassColorList,
                            showLegends: false,
                          ),
                          Positioned.fill(
                            child: Center(
                              child: RawMaterialButton(
                                onPressed: () {
                                  setState(() {
                                    isCompassOn = !isCompassOn;
                                  });
                                },
                                elevation: 8.0,
                                fillColor: isCompassOn
                                    ? Constants.backgroundColor
                                    : Constants.backgroundColor
                                        .withOpacity(0.5),
                                child: Icon(
                                  isCompassOn
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
                    ),
                    _buildLabelText('Item images:', ''),
                    CarouselSlider(
                      options: CarouselOptions(
                        aspectRatio: 2.0,
                        enlargeCenterPage: true,
                        enableInfiniteScroll: false,
                      ),
                      items: imageSliders,
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildLabelText(String label, String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: RichText(
        text: TextSpan(
          style: TextStyle(color: Colors.black, fontSize: 20),
          children: <TextSpan>[
            TextSpan(
              text: label,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            TextSpan(text: text),
          ],
        ),
      ),
    );
  }
}

class ItemsListView extends StatefulWidget {
  final Order order;
  final void Function(int) setCurrentItemIndex;

  ItemsListView(this.order, {this.setCurrentItemIndex});

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
          return Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  left: 10,
                  top: index == 0 ? 20 : 0,
                  bottom: index == widget.order.items.length - 1 ? 40 : 0,
                ),
                child: Material(
                  color: Colors.white,
                  child: InkWell(
                    child: Row(
                      children: [
                        Image.network(
                          item.imageUrl,
                          fit: BoxFit.contain,
                          height: 50,
                          width: 50,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Text(
                            item.name,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    onTap: () {
                      widget.setCurrentItemIndex(index);
                    },
                  ),
                ),
              ),
              Divider(),
            ],
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
