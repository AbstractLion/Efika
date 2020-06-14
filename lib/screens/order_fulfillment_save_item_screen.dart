import 'package:camera/camera.dart';
import 'package:efika/constants.dart';
import 'package:efika/globals.dart' as globals;
import 'package:flutter/material.dart';
import 'package:intro_views_flutter/Models/page_view_model.dart';
// import 'package:intro_views_flutter/intro_views_flutter.dart';

/*
  This screen is displayed when the user checks off an item that hasn't been
  stored in the database.
 */

class OrderFulfillmentSaveItemScreen extends StatefulWidget {
  static const routeName = '/order_fulfillment_save_item';

  @override
  State<StatefulWidget> createState() => _OrderFulfillmentSaveItemScreenState();
}

class _OrderFulfillmentSaveItemScreenState
    extends State<OrderFulfillmentSaveItemScreen> {
  CameraController controller;
  final List<PageViewModel> _pages = [
    PageViewModel(
      pageColor: Constants.backgroundColor,
      body: Container(),
      title: Text("Save this item's location!", textAlign: TextAlign.center),
      mainImage: Container(
        child: Text(
          "The location of this item hasn't been found in our database. Help future workers find this item more easily by taking a picture of its location with its surroundings!",
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
      ),
    )
  ];

  @override
  void initState() {
    super.initState();
    controller = CameraController(globals.cameras[0], ResolutionPreset.medium);
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    /*
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
     */

    if (!controller.value.isInitialized) {
      return Center(child: Text('Loading...'));
    }
    return AspectRatio(
      aspectRatio: controller.value.aspectRatio,
      child: CameraPreview(controller),
    );
  }
}
