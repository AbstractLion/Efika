import 'package:efika/models/item.dart';
import 'package:flutter/material.dart';

import '../widgets/efika_app_bar.dart';

class ItemDetailsScreen extends StatelessWidget {
  static const String routeName = '/item_details';

  @override
  Widget build(BuildContext context) {
    final Item item = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: EfikaAppBar(
        title: Text('Item Details'),
      ),
      body: Container(),
    );
  }
}
