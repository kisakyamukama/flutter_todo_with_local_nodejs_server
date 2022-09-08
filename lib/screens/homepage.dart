import 'package:flutter/material.dart';

import '../widgets/add_new_task.dart';
import '../widgets/list.dart';

//Homepage of the app. It allows the user to insert new tasks to his list.
//It'll allow the user to add new lists too (later features).

class Homepage extends StatelessWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //  Provider.of<TaskProvider>(context, listen: false).getTodos();
    return Scaffold(
      appBar: AppBar(
        title: const Text('TO DO LIST'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (_) => AddNewTask(isEditMode: false, id: '',),
              );
            },
          ),
        ],
      ),
      body: const List(),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (_) => AddNewTask(isEditMode: false, id: '',),
          );
        },
        tooltip: 'Add a new item!',
      ),
    );
  }
}