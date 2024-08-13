// To parse this JSON data, do
//
//     final notesListResponseModel = notesListResponseModelFromJson(jsonString);

import 'dart:convert';

NotesListResponseModel notesListResponseModelFromJson(String str) => NotesListResponseModel.fromJson(json.decode(str));

String notesListResponseModelToJson(NotesListResponseModel data) => json.encode(data.toJson());

class NotesListResponseModel {
  List<NoteListDataModel>? data;
  int? count;
  String? message;
  int? status;

  NotesListResponseModel({
    this.data,
    this.count,
    this.message,
    this.status,
  });

  factory NotesListResponseModel.fromJson(Map<String, dynamic> json) => NotesListResponseModel(
    data: json["data"] == null ? [] : List<NoteListDataModel>.from(json["data"]!.map((x) => NoteListDataModel.fromJson(x))),
    count: json["count"],
    message: json["message"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "count": count,
    "message": message,
    "status": status,
  };
}

class NoteListDataModel {
  String? id;
  DateTime? createdAt;
  String? description;
  String? title;
  String? userId;
  String? noteStatus;

  NoteListDataModel({
    this.id,
    this.createdAt,
    this.description,
    this.title,
    this.userId,
    this.noteStatus,
  });

  factory NoteListDataModel.fromJson(Map<String, dynamic> json) => NoteListDataModel(
    id: json["id"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    description: json["description"],
    title: json["title"],
    userId: json["userId"],
    noteStatus: json["noteStatus"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "createdAt": createdAt?.toIso8601String(),
    "description": description,
    "title": title,
    "userId": userId,
    "noteStatus": noteStatus,
  };
}
