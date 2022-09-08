import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_todo_app/model/task_model.dart';
import 'package:http/http.dart' as http;

class TaskProvider with ChangeNotifier {
  Map<String, String> headers = {'Content-Type': 'application/json'};
  final apiURL = 'http://192.168.248.147:3001/api/todo';

  List<Task> get itemsList => _toDoList;

  List<Task> _toDoList = [];

  Task getById(String id) {
    return _toDoList.firstWhere((task) => task.id == id);
  }

  void createNewTask(Task task) async {
    var json = task.toJson();

    debugPrint('Task json $json');
    await postTodo(json);
    debugPrint(task.description);

    notifyListeners();
  }

  void editTask(Task task) async {
    int id = int.parse(task.id);
    await editTodo(task.toJson(), id);
    // removeTask(task.id);
    // createNewTask(task);
  }

  Future removeTask(String id) async {
    int taskId = int.parse(id);
    await deleteTodo(taskId);
    notifyListeners();
  }

  void changeStatus(String id, Task task) async {
    final newTask = Task(
      id: task.id,
      description: task.description,
      dueDate: task.dueDate,
      isDone: !task.isDone,
      dueTime: task.dueTime,
    );

    int taskId = int.parse(id);
    await editTodo(newTask.toJson(), taskId);
  }

  // api CALLS

  // get todos
  Future getTodos() async {
    Uri url = Uri.parse(apiURL);
    var response = await http.get(url);
    debugPrint('API GET TODO resposne ${response.body}');
    if (response.statusCode == 200) {
      var responseJson = jsonDecode(response.body)['response'];
      debugPrint('response json $responseJson');
      List todos = responseJson.map((json) => Task.fromJson(json)).toList();

      debugPrint('Parsed todos ${todos.length}');
      if (todos.isNotEmpty) {
        _toDoList = [];
        _toDoList.insertAll(0, todos.cast());
        notifyListeners();
      }
    }
  }

  // create todo
  Future postTodo(var body) async {
    Uri url = Uri.parse(apiURL);
    var jsonBody = jsonEncode(body);
    var response = await http.post(url, headers: headers, body: jsonBody);
    debugPrint('API POST TODO resposne ${response.body}');
    if (response.statusCode == 200) {
      var responseJson = jsonDecode(response.body)['response'];
      debugPrint('response json $responseJson');
      getTodos();
      notifyListeners();
    }
  }

  // edit todo
  // create todo
  Future editTodo(var body, int id) async {
    Uri url = Uri.parse(apiURL + '/$id');
    var jsonBody = jsonEncode(body);
    var response = await http.put(url, headers: headers, body: jsonBody);
    debugPrint('API PUT TODO resposne ${response.body}');
    if (response.statusCode == 200) {
      var responseJson = jsonDecode(response.body)['response'];
      debugPrint('response json $responseJson');
      getTodos();
      notifyListeners();
    }
  }

  Future deleteTodo(int id) async {
    try {
      Uri url = Uri.parse(apiURL + '/$id');
      var response = await http.delete(
        url,
        headers: headers,
      );
      debugPrint('API DELETE TODO resposne ${response.body}');
      if (response.statusCode == 200) {
        var responseJson = jsonDecode(response.body)['response'];
        debugPrint('response json $responseJson');
        getTodos();
        notifyListeners();
      }
    } catch (e) {
      debugPrint('$e');
    }
  }
}
