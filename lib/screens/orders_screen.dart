import 'package:efika/models/order.dart';
import 'package:efika/models/orders.dart';
import 'package:efika/screens/order_fulfillment_screen.dart';
import 'package:efika/screens/paccurate_screen.dart';
import 'package:efika/widgets/user_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_beautiful_popup/main.dart';
import 'package:flutter_beautiful_popup/templates/Common.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

import '../constants.dart';

class OrdersScreen extends StatelessWidget {
  BeautifulPopup _popup;

  @override
  Widget build(BuildContext context) {
    _popup = BeautifulPopup.customize(
      context: context,
      build: (options) => _DeliveryPopupTemplate(options),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Orders'),
        actions: <Widget>[
          IconButton(
            icon: FaIcon(FontAwesomeIcons.boxes),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PaccurateScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: Orders.orders.length,
        itemBuilder: _buildOrderCard,
      ),
    );
  }

  Widget _buildOrderCard(BuildContext context, int index) {
    Order order = Orders.orders[index];

    return Padding(
      padding: EdgeInsets.fromLTRB(
        10.0,
        index == 0 ? 10.0 : 0,
        10.0,
        10.0,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 6.0,
            ),
          ],
        ),
        padding: EdgeInsets.all(10.0),
        child: Material(
          child: InkWell(
            onTap: () {
              _popup.show(
                title: 'Order Details',
                content: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildLabelText('Order ID: ', order.id.toString()),
                      _buildLabelText('Ordered at: ',
                          DateFormat.yMd().add_jm().format(order.dateOrdered)),
                      _buildLabelText('Ordered by: ', order.orderer.name),
                      _buildLabelText(
                          '# of items: ', order.items.length.toString()),
                      _buildLabelText(
                          'Approximate Time: ',
                          (order.items.length * 0.74).round().toString() +
                              ' minutes'),
                      _buildLabelText("Can all items fit in a basket? ", "No")
                    ],
                  ),
                ),
                actions: [
                  _popup.button(
                    label: 'Cancel',
                    onPressed: Navigator.of(context).pop,
                  ),
                  _popup.button(
                    label: 'Fulfill',
                    onPressed: () {
                      Navigator.pushReplacementNamed(
                        context,
                        OrderFulfillmentScreen.routeName,
                        arguments: RouteParams(
                          index,
                        ),
                      );
                    },
                  ),
                ],
              );
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 10),
                      child: UserAvatar(order.orderer.avatarUrl),
                    ),
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildLabelText('Order ID: ', order.id.toString()),
                          _buildLabelText(
                              'Ordered at: ',
                              DateFormat.yMd()
                                  .add_jm()
                                  .format(order.dateOrdered)),
                          _buildLabelText('Ordered by: ', order.orderer.name)
                        ],
                      ),
                    ),
                  ],
                ),
                Container(
                  child: Row(
                    children: [
                      Text('Fulfill Order'),
                      Icon(Icons.chevron_right),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLabelText(String label, String text) {
    return RichText(
      text: TextSpan(
        style: TextStyle(color: Colors.black),
        children: <TextSpan>[
          TextSpan(
            text: label,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
          TextSpan(text: text, style: TextStyle(fontSize: 14)),
        ],
      ),
    );
  }
}

class _DeliveryPopupTemplate extends BeautifulPopupTemplate {
  final BeautifulPopup options;
  _DeliveryPopupTemplate(this.options) : super(options);

  @override
  String get illustrationKey => 'assets/box_bg.png';

  @override
  Color get primaryColor => Constants.backgroundColor;
  @override
  final maxWidth = 400;
  @override
  final maxHeight = 580;
  @override
  final bodyMargin = 30;

  @override
  BeautifulPopupButton get button {
    return ({
      @required String label,
      @required void Function() onPressed,
      bool outline = false,
      bool flat = false,
      TextStyle labelStyle = const TextStyle(),
    }) {
      final gradient = LinearGradient(colors: [
        primaryColor.withOpacity(0.5),
        primaryColor,
      ]);
      final double elevation = (outline || flat) ? 0 : 2;
      final labelColor =
          (outline || flat) ? primaryColor : Colors.white.withOpacity(0.95);
      final decoration = BoxDecoration(
        gradient: (outline || flat) ? null : gradient,
        borderRadius: BorderRadius.all(Radius.circular(80.0)),
        border: Border.all(
          color: outline ? primaryColor : Colors.transparent,
          width: (outline && !flat) ? 1 : 0,
        ),
      );
      final minHeight = 40.0 - (outline ? 4 : 0);
      return RaisedButton(
        color: Colors.transparent,
        elevation: elevation,
        highlightElevation: 0,
        splashColor: Colors.transparent,
        child: Ink(
          decoration: decoration,
          child: Container(
            constraints: BoxConstraints(
              minWidth: 100,
              minHeight: minHeight,
            ),
            alignment: Alignment.center,
            child: Text(
              label,
              style: TextStyle(
                color: Colors.white.withOpacity(0.95),
                fontWeight: FontWeight.bold,
              ).merge(labelStyle),
            ),
          ),
        ),
        padding: EdgeInsets.all(0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        onPressed: onPressed,
      );
    };
  }

  @override
  get layout {
    return [
      Positioned(
        child: background,
      ),
      Positioned(
        top: percentH(30),
        child: title,
      ),
      Positioned(
        top: percentH(40),
        left: percentW(5),
        right: percentW(5),
        height: percentH(actions == null ? 60 : 50),
        child: content,
      ),
      Positioned(
        bottom: percentW(5),
        left: percentW(5),
        right: percentW(5),
        child: actions ?? Container(),
      ),
    ];
  }
}
