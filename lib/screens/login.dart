import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;
import 'package:flutter_login/flutter_login.dart';
import 'package:geomhacks/screens/home.dart';

import '../constants.dart';

class LoginScreen extends StatelessWidget {
  static const routeName = '/auth';

  Duration get loginTime => Duration(milliseconds: timeDilation.ceil() * 2250);

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      title: Constants.appName,
      logo: 'assets/images/ecorp.png',
      logoTag: Constants.logoTag,
      titleTag: Constants.titleTag,
      emailValidator: (value) {
        return null;
      },
      passwordValidator: (value) {
        return null;
      },
      onLogin: (loginData) {
        return null;
      },
      onSignup: (loginData) {
        return null;
      },
      onSubmitAnimationCompleted: () {
        Navigator.of(context).pushReplacement(FadePageRoute(
          builder: (context) => HomeNavigation(),
        ));
      },
      onRecoverPassword: (name) {
        return null;
      },
    );
  }
}

class FadePageRoute<T> extends MaterialPageRoute<T> {
  FadePageRoute({
    WidgetBuilder builder,
    RouteSettings settings,
  }) : super(
          builder: builder,
          settings: settings,
        );

  @override
  Duration get transitionDuration => const Duration(milliseconds: 600);

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return FadeTransition(
      opacity: animation,
      child: child,
    );
  }
}
