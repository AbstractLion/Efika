import 'package:efika/models/workers.dart';
import 'package:efika/screens/profile_screen.dart';
import 'package:efika/widgets/user_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:getflutter/getflutter.dart';
import 'package:provider/provider.dart';
import 'package:search_app_bar/filter.dart';
import 'package:search_app_bar/search_app_bar.dart';

import '../models/user.dart';

/*
  Contains a searchable list of coworkers
 */

class CoworkersScreenAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        SearchAppBar<User>(
          title: Text('Coworkers'),
          filter: (User worker, String search) {
            return Filters.contains(worker.name, search);
          },
          searcher: context.watch<Workers>(),
          iconTheme: IconThemeData(color: Colors.white),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(56);
}

class CoworkersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<User> filteredWorkers = context.watch<Workers>().filteredWorkers;
    return Scaffold(
      appBar: CoworkersScreenAppBar(),
      body: ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return _buildWorkerCard(context, filteredWorkers[index]);
        },
        itemCount: filteredWorkers.length,
      ),
    );
  }

  Widget _buildWorkerCard(BuildContext context, User worker) {
    return InkWell(
      child: GFListTile(
        titleText: worker.name,
        avatar: UserAvatar(worker.avatarUrl),
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProfileScreen(worker),
          ),
        );
      },
    );
  }
}
