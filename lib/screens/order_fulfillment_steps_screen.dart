import 'package:flutter/material.dart';
import 'package:intro_views_flutter/Models/page_view_model.dart';
import 'package:intro_views_flutter/intro_views_flutter.dart';

class OrderFulfillmentStepsScreen extends StatelessWidget {
  static const routeName = '/order_fulfillment_steps';

  final List<PageViewModel> _pages = [
    PageViewModel(
      pageColor: Color(0xFF607D8B),
    )
  ];

  @override
  Widget build(BuildContext context) {
    final Widget stepsViews = IntroViewsFlutter(
      _pages,
      onTapDoneButton: () {},
      showSkipButton: true,
      pageButtonTextStyles: TextStyle(
        color: Colors.white,
        fontSize: 18.0,
      ),
    );

    return stepsViews;
  }
}
