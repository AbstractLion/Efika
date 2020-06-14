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
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:photo_view/photo_view.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../constants.dart';

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
  Future<void> _initializeControllerFuture;
  CameraController _controller;
  PanelController _pc = PanelController();
  String _imagePath;
  List<Slide> stepSlides = [];

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
                        onPressed: () {},
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
    Map<String, double> compassMap = Map();
    compassMap.putIfAbsent('OtherPositions', () => 20);
    compassMap.putIfAbsent('ItemPosition', () => 1);

    return Slide(
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

          final List<Color> compassColorList = [
            Constants.backgroundColor.withOpacity(0.3),
            Constants.accentColor,
          ];

          return Stack(
            children: [
              PieChart(
                dataMap: compassMap,
                chartType: ChartType.ring,
                showChartValueLabel: false,
                showChartValues: false,
                showChartValuesInPercentage: false,
                showChartValuesOutside: false,
                chartRadius: 150,
                initialAngle: direction * pi / 180,
                chartValueStyle: TextStyle(color: Colors.transparent),
                colorList: compassColorList,
                showLegends: false,
              ),
              // Positioned.fill(
              // ),
            ],
          );
        },
      ),
    );
  }
}
