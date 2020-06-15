import 'package:efika/models/user.dart';
import 'package:efika/widgets/efika_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:getflutter/components/avatar/gf_avatar.dart';
import 'package:getflutter/getflutter.dart';

class ProfileScreen extends StatelessWidget {
  final User user;
  ProfileScreen(this.user);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: EfikaAppBar(
        title: Text('Profile'),
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Spacer(flex: 3),
              GFAvatar(
                backgroundImage: NetworkImage(
                  user.avatarUrl,
                ),
                size: GFSize.LARGE * 3,
              ),
              Spacer(),
              Text(
                user.name,
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Spacer(),
              Row(
                children: <Widget>[
                  Text("Store: ",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                  Text("Walmart", style: TextStyle(fontSize: 15)),
                ],
              ),
              Spacer(),
              Row(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(right: 10),
                    child: Column(
                      children: <Widget>[
                        Text(user.fulfillments.toString(), style: TextStyle(fontSize: 20)),
                        Text("Fulfillments"),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Column(
                      children: <Widget>[
                        Text(user.itemsSaved.toString(), style: TextStyle(fontSize: 20)),
                        Text("Items Saved"),
                      ],
                    ),
                  ),
                ],
              ),
              Spacer(flex: 4),
            ],
          ),
        ],
      ),
    );
  }
}
