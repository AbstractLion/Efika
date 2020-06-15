import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaccurateScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shelf Packing'),
      ),
      body: Stack(
        children: [
          WebView(
            initialUrl: 'https://efika-geom.herokuapp.com/get-svg',
          ),
          Padding(
            padding: EdgeInsets.all(5),
            child: Text(
              "Here, you can use Paccurate to find out the most efficient way to pack a shelf, suited towards stores where you need to pack a lot of assorted items on one shelf (e.g. Thrift Stores).",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
