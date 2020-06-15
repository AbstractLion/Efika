import 'package:camera/camera.dart';
import 'package:efika/constants.dart';
import 'package:efika/screens/intro_screen.dart';
import 'package:efika/screens/order_fulfillment_screen.dart';
import 'package:expandable_bottom_bar/expandable_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:overlay_support/overlay_support.dart';

import 'globals.dart' as globals;
import 'models/items.dart';
import 'models/orders.dart';
import 'models/users.dart';
import 'screens/home_screen.dart';
import 'screens/login_screen.dart';

Future<void> main() async {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      systemNavigationBarColor:
          SystemUiOverlayStyle.dark.systemNavigationBarColor,
    ),
  );
  try {
    WidgetsFlutterBinding.ensureInitialized();
    globals.cameras = await availableCameras();
  } on CameraException catch (e) {
    print(e.code + e.description);
  }
  await Items.parseInformation();
  await Users.parseUsers();
  Orders.generateOrders();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return OverlaySupport(
      child: MaterialApp(
        title: 'Login Demo',
        theme: ThemeData(
          primaryColor: Color.fromRGBO(0, 148, 222, 1),
          accentColor: Constants.accentColor,
          cursorColor: Colors.white,
          // fontFamily: 'SourceSansPro',
          textTheme: TextTheme(
            headline3: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 45.0,
              // fontWeight: FontWeight.w400,
              color: Colors.white,
            ),
            button: TextStyle(
              // OpenSans is similar to NotoSans but the uppercases look a bit better IMO
              fontFamily: 'OpenSans',
            ),
            caption: TextStyle(
              fontFamily: 'NotoSans',
              fontSize: 12.0,
              fontWeight: FontWeight.normal,
            ),
            headline1: TextStyle(fontFamily: 'Quicksand'),
            headline2: TextStyle(fontFamily: 'Quicksand'),
            headline4: TextStyle(fontFamily: 'NotoSans'),
            headline5: TextStyle(fontFamily: 'NotoSans'),
            headline6: TextStyle(fontFamily: 'Quicksand'),
            subtitle1: TextStyle(fontFamily: 'NotoSans'),
            subtitle2: TextStyle(fontFamily: 'NotoSans'),
            bodyText1: TextStyle(fontFamily: 'NotoSans'),
            bodyText2: TextStyle(fontFamily: 'NotoSans'),
            overline: TextStyle(fontFamily: 'NotoSans'),
          ),
        ),
        home: IntroScreen(),
        routes: {
          IntroScreen.routeName: (context) => IntroScreen(),
          LoginScreen.routeName: (context) => LoginScreen(),
          HomeScreen.routeName: (context) => HomeScreen(),
          OrderFulfillmentScreen.routeName: (context) =>
              DefaultBottomBarController(
                child: OrderFulfillmentScreen(),
              ),
        },
      ),
    );
  }
}
