import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Task {
  final String id;
  String description;
  DateTime dueDate;
  TimeOfDay dueTime;
  bool isDone;

  Task({
    required this.id,
    required this.description,
    required this.dueDate,
    required this.dueTime,
    this.isDone = false,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    DateTime date = getDateTime(json['dueDate']);
    // TimeOfDay time = TimeOfDay(hour: hour, minute: minute)
    return Task(
        id: json['id'].toString(),
        description: json['todo'],
        dueDate: date,
        isDone: json['isDone'] == 1 ? true : false,
        dueTime: TimeOfDay.now());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['todo'] = description;
    data['isDone'] = isDone;
    data['dueDate'] = dueDate.toString();
    data['dueTime'] = '${dueTime.hour}:${dueTime.minute}';
    return data;
  }
}

getDateTime(String datetime) {
  var dateFormat =
      DateFormat("dd-MM-yyyy hh:mm aa"); // you can change the format here
  var utcDate =
      dateFormat.format(DateTime.parse(datetime)); // pass the UTC time here
  var localDate = dateFormat.parse(utcDate, true).toLocal().toString();
  DateTime convertedTime =DateTime.parse(localDate); // you will local time
  // debugPrint('Converteddate $convertedTime');
  return convertedTime;
}
