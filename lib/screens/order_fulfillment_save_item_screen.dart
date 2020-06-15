import 'dart:io';
import 'dart:math';

import 'package:camera/camera.dart';
import 'package:efika/globals.dart' as globals;
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:getflutter/getflutter.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:photo_view/photo_view.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../constants.dart';

/*
  This screen is displayed when the user checks off an item that hasn't been
  stored in the database.
 */

class OrderFulfillmentSaveItemScreen extends StatefulWidget {
  static const routeName = '/order_fulfillment_save_item';

  final void Function(int) setItemIndex;
  final int itemIndex;

  OrderFulfillmentSaveItemScreen(
      {@required this.itemIndex, @required this.setItemIndex});

  @override
  State<StatefulWidget> createState() => _OrderFulfillmentSaveItemScreenState();
}

class _OrderFulfillmentSaveItemScreenState
    extends State<OrderFulfillmentSaveItemScreen> {
  Future<void> _initializeControllerFuture;
  CameraController _controller;
  PanelController _pc = PanelController();
  String _imagePath;
  List<Slide> stepSlides = [];
  void Function(int) goToTab;

  @override
  void initState() {
    super.initState();
    _controller = CameraController(globals.cameras[0], ResolutionPreset.medium);
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    stepSlides.clear();
    stepSlides.add(_createCameraSlide(context));
    stepSlides.add(_createCompassSlide(context));

    final BorderRadiusGeometry radius = BorderRadius.only(
      topLeft: Radius.circular(24.0),
      topRight: Radius.circular(24.0),
    );

    return new SlidingUpPanel(
      minHeight: 0,
      maxHeight: MediaQuery.of(context).size.height - 100,
      controller: _pc,
      header: Container(
        width: MediaQuery.of(context).size.width,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: radius,
        ),
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Container(
              height: 5,
              width: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(3)),
                color: Colors.grey,
              ),
            ),
          ),
        ),
      ),
      borderRadius: radius,
      panel: Scaffold(
        body: Container(
          child: ListView(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 25),
                child: Text(
                  'Image Review',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
              ),
              Container(
                height: 400,
                width: double.infinity,
                child: _imagePath == null
                    ? Container(
                        height: 50,
                        width: 50,
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      )
                    : ClipRect(
                        child: PhotoView(
                          imageProvider: FileImage(File(_imagePath)),
                        ),
                      ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: 10, top: 10, bottom: 10, right: 5),
                      child: GFButton(
                        text: 'Retake',
                        onPressed: () async {
                          await _pc.close();
                          await _pc.hide();
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: 5, top: 10, bottom: 10, right: 10),
                      child: GFButton(
                        text: 'Confirm',
                        color: Constants.accentColor,
                        onPressed: () async {
                          await _pc.close();
                          await _pc.hide();
                          this.goToTab(1);
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      body: IntroSlider(
        slides: stepSlides,
        onDonePress: () {
          widget.setItemIndex(widget.itemIndex + 1);
          Navigator.of(context).pop();
        },
        onSkipPress: () {
          widget.setItemIndex(widget.itemIndex + 1);
          Navigator.of(context).pop();
        },
        refFuncGoToTab: (refFunc) {
          this.goToTab = refFunc;
        },
      ),
    );
  }

  Slide _createCameraSlide(BuildContext context) {
    Widget cameraWidget = FutureBuilder<void>(
      future: _initializeControllerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Container(
            height: 400,
            child: AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: CameraPreview(_controller),
            ),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );

    return Slide(
      title: "Save this item's location!",
      styleTitle: TextStyle(color: Colors.black, fontSize: 20),
      styleDescription: TextStyle(color: Colors.black, fontSize: 13),
      description:
          "The location of this item hasn't been found in our database. Help future workers find this item more easily by taking a picture of its location with its surroundings!",
      centerWidget: Container(
        child: Column(
          children: [
            cameraWidget,
            GFButton(
              text: 'Capture Image',
              icon: Icon(Icons.camera, color: Colors.white),
              onPressed: () async {
                try {
                  await _initializeControllerFuture;

                  final String imagePath = join(
                      (await getTemporaryDirectory()).path,
                      '${DateTime.now()}.png');

                  await _controller.takePicture(imagePath);

                  setState(() {
                    _imagePath = imagePath;
                    print(_imagePath);
                  });

                  await _pc.show();
                  await _pc.open();
                } catch (e) {
                  print('Error: ' + e);
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Slide _createCompassSlide(BuildContext context) {
    return Slide(
      styleTitle: TextStyle(
          color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
      title: "Save the item's position.",
      widgetDescription: Column(
        children: [
          Text(
            "Please stand facing the aisle at the northern/eastern end of the aisle and point the phone in the direction of the item. Then, press the button below to save the item's relative position for other workers to locate more easily next time.",
            style: TextStyle(color: Colors.black),
          ),
          GFButton(
            text: 'Save',
            onPressed: () async {
              final double tmp = await FlutterCompass.events.first;
              showSimpleNotification(
                Text("The item's orientation has been saved at " +
                    tmp.toString() +
                    "°"),
                background: Colors.green,
              );
            },
          ),
        ],
      ),
      centerWidget: StreamBuilder<double>(
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

          return Container(
            constraints: BoxConstraints.tightFor(width: 200, height: 200),
            alignment: Alignment.center,
            child: Transform.rotate(
              angle: ((direction ?? 0) * (pi / 180) * -1),
              child: Image.asset('assets/compass.png'),
            ),
          );
        },
      ),
    );
  }
}
