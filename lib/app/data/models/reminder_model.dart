// To parse this JSON data, do
//
//     final reminder = reminderFromJson(jsonString);

import 'dart:convert';

Reminder reminderFromJson(String str) => Reminder.fromJson(json.decode(str));

String reminderToJson(Reminder data) => json.encode(data.toJson());
List<Reminder> reminderFromList(List<dynamic> listDynamic) =>
    List<Reminder>.from(listDynamic.map((x) => Reminder.fromJson(x)));

class Reminder {
  String id;
  String userId;
  DateTime startDate;
  DateTime endDate;
  String reminderTime;
  String title;
  String description;
  String? response;
  bool status;
  bool isComplete;
  DateTime createdAt;
  DateTime updatedAt;

  Reminder({
    required this.id,
    required this.userId,
    required this.startDate,
    required this.endDate,
    required this.reminderTime,
    required this.title,
    required this.description,
    required this.status,
    required this.isComplete,
    required this.createdAt,
    required this.updatedAt,
    this.response,
  });

  factory Reminder.fromJson(Map<String, dynamic> json) => Reminder(
        id: json["_id"],
        userId: json["userId"],
        startDate: DateTime.parse(json["startDate"]),
        endDate: DateTime.parse(json["endDate"]),
        reminderTime: json["reminderTime"],
        response: json["reminder"],
        title: json["title"],
        description: json["description"],
        status: json["status"],
        isComplete: json["isComplete"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "userId": userId,
        "startDate": startDate.toIso8601String(),
        "endDate": endDate.toIso8601String(),
        "reminderTime": reminderTime,
        "title": title,
        "description": description,
        "status": status,
        "isComplete": isComplete,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}
