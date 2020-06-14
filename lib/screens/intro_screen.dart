import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

import '../constants.dart';

class IntroScreen extends StatefulWidget {
  static const String routeName = '/intro';
  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) {
    Navigator.of(context).pushReplacementNamed('/login');
  }

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 19.0, color: Colors.white);
    const pageDecoration = const PageDecoration(
      titleTextStyle: TextStyle(
        fontSize: 28.0,
        fontWeight: FontWeight.w700,
        color: Colors.white,
      ),
      bodyTextStyle: bodyStyle,
      descriptionPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Constants.backgroundColor,
      imagePadding: EdgeInsets.zero,
    );

    return IntroductionScreen(
      key: introKey,
      pages: [
        PageViewModel(
          title: "Efika - Helping workers and customers shop more efficiently.",
          image: Image.asset('assets/logo.png'),
          body:
              "With the COVID-19 pandemic causing a sharp increase in the demand for pickups and deliveries, we figured that we needed to provide workers an easy way to retrieve the items required to fulfill a customer's purchase.",
          decoration: pageDecoration,
        ),
        PageViewModel(
          title:
              "Tired of having different workers struggle to locate the same items again and again?",
          image: Container(),
          body:
              "Efika makes sure that when a worker finds an item, that it'll be easy for the next worker to find it, even if they haven't ever seen it before.",
          decoration: pageDecoration,
        ),
        PageViewModel(
          title:
              "Struggling with a slow and unorganized method of obtaining items?",
          image: Container(),
          body:
              "With enough information, Efika can generate an efficient path for a worker to retrieve all their items in one go, saving time and hassle.",
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Worried about an incomplete inventory?",
          image: Container(),
          body:
              "Efika is to be used by both customers and workers, so that customers can also contribute to helping populate an exhaustive inventory for your store.",
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Ready to get started with Efika?",
          image: Container(),
          body: '',
          decoration: pageDecoration,
        ),
      ],
      onDone: () => _onIntroEnd(context),
      onSkip: () => _onIntroEnd(context), // You can override onSkip callback
      showSkipButton: true,
      skipFlex: 0,
      nextFlex: 0,
      skip: const Text('Skip', style: TextStyle(color: Colors.white)),
      next: const Icon(Icons.arrow_forward),
      done: const Text('Done',
          style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white)),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        color: Color(0xFFBDBDBD),
        activeColor: Colors.white,
        activeSize: Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
    );
  }
}
