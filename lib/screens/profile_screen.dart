import 'package:efika/widgets/efika_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:getflutter/components/avatar/gf_avatar.dart';
import 'package:getflutter/getflutter.dart';

class ProfileScreen extends StatelessWidget {
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
                    "https://media.discordapp.net/attachments/721448995322331167/721455140804231496/0.png"),
                size: GFSize.LARGE * 3,
              ),
              Spacer(),
              Text("Leon Si", style: TextStyle(fontSize: 30)),
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
                  Column(
                    children: <Widget>[
                      Text("345", style: TextStyle(fontSize: 20)),
                      Text("Fulfillments"),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Text("3452", style: TextStyle(fontSize: 20)),
                      Text("Items Saved"),
                    ],
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
