import 'package:efika/models/workers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:getflutter/getflutter.dart';
import 'package:provider/provider.dart';
import 'package:search_app_bar/filter.dart';
import 'package:search_app_bar/search_app_bar.dart';

import '../models/worker.dart';

/*
  Contains a searchable list of coworkers
 */

class CoworkersScreenAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        SearchAppBar<Worker>(
          title: Text('Coworkers'),
          filter: (Worker worker, String search) {
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
    List<Worker> filteredWorkers = context.watch<Workers>().filteredWorkers;
    print(filteredWorkers);
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

  Widget _buildWorkerCard(BuildContext context, Worker worker) {
    return GFListTile(
      titleText: worker.name,
      avatar: worker.avatarUrl == null
          ? Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.black12,
                border: Border.all(color: Colors.black),
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
                backgroundImage: NetworkImage(worker.avatarUrl),
              ),
            ),
    );
  }
}
