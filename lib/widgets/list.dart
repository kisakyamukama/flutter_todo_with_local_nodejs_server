import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/task_provider.dart';
import './list_item.dart';

//Parent widget of all ListItems, this widget role is just to group all list tiles.

class List extends StatelessWidget {
  const List({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final taskList = Provider.of<TaskProvider>(context).itemsList;
    return Consumer<TaskProvider>(
        builder: (context, TaskProvider tProvider, child) {
      final taskList = tProvider.itemsList;
      if (taskList.length == 0) tProvider.getTodos();
      return taskList.isNotEmpty
          ? ListView.builder(
              itemCount: taskList.length,
              itemBuilder: (context, index) {
                return ListItem(taskList[index]);
              },
            )
          : LayoutBuilder(
              builder: (ctx, constraints) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      // Container(
                      //   height: constraints.maxHeight * 0.5,
                      //   child: Image.asset('assets/images/waiting.png',
                      //       fit: BoxFit.cover),
                      // ),
                      // SizedBox(
                      //   height: 30,
                      // ),
                      Text(
                        'No tasks added yet...',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ],
                  ),
                );
              },
            );
    });
  }
}
