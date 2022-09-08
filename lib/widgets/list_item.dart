import 'package:flutter/material.dart';
import 'package:flutter_todo_app/model/task_model.dart';
import 'package:provider/provider.dart';

import '../providers/task_provider.dart';
import '../widgets/add_new_task.dart';
import './item_text.dart';

//A widget that composes every single item in the list.
//Allows the user to check it as done.
//Deletes a task when dismissed.
//### MISSING FEATURES ###
// Edit a task through the icon button.

class ListItem extends StatefulWidget {
  final Task task;

  const ListItem(this.task, {Key? key}) : super(key: key);

  @override
  _ListItemState createState() => _ListItemState();
}

class _ListItemState extends State<ListItem> {

   void _checkItem() {
      setState(() {
        Provider.of<TaskProvider>(context, listen: false)
            .changeStatus(widget.task.id,widget.task);
        //print('SET STATE ${widget.task.isDone.toString()}');
      });
    }
  @override
  Widget build(BuildContext context) {
   

    return Dismissible(
      key: ValueKey(widget.task.id),
      direction: DismissDirection.endToStart,
      onDismissed: (_) async{
       await Provider.of<TaskProvider>(context, listen: false)
            .removeTask(widget.task.id);
      },
      background: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              'DELETE',
              style: TextStyle(
                color: Theme.of(context).errorColor,
                fontFamily: 'Lato',
                fontSize: 16,
              ),
            ),
            const SizedBox(width: 5),
            Icon(
              Icons.delete,
              color: Theme.of(context).errorColor,
              size: 28,
            ),
          ],
        ),
      ),
      child: GestureDetector(
        onTap: _checkItem,
        child: SizedBox(
          height: 65,
          child: Card(
            elevation: 10,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Checkbox(
                      value: widget.task.isDone,
                      onChanged: (_) => _checkItem(),
                    ),
                    ItemText(
                      widget.task.isDone,
                      widget.task.description,
                      widget.task.dueDate,
                      widget.task.dueTime,
                    ),
                  ],
                ),
                if (!widget.task.isDone)
                  IconButton(
                    icon:const Icon(Icons.edit),
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (_) => AddNewTask(
                          id: widget.task.id,
                          isEditMode: true,
                        ),
                      );
                    },
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}