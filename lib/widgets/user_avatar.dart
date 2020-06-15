import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:getflutter/getflutter.dart';

import '../constants.dart';

class UserAvatar extends StatelessWidget {
  final String imageUrl;

  UserAvatar(this.imageUrl);

  @override
  Widget build(BuildContext context) {
    return imageUrl == null
        ? Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.black12,
              border: Border.all(color: Constants.backgroundColor),
            ),
            padding: EdgeInsets.all(15),
            child: Icon(
              FontAwesomeIcons.user,
            ),
          )
        : Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.black12,
              border: Border.all(color: Colors.black),
            ),
            child: GFAvatar(
              backgroundImage: NetworkImage(imageUrl),
            ),
          );
  }
}
