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

  NotesListResponseModel({
    this.data,
    this.count,
    this.message,
  });

  factory NotesListResponseModel.fromJson(Map<String, dynamic> json) => NotesListResponseModel(
    data: json["data"] == null ? [] : List<NoteListDataModel>.from(json["data"]!.map((x) => NoteListDataModel.fromJson(x))),
    count: json["count"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "count": count,
    "message": message,
  };
}

class NoteListDataModel {
  String? id;
  String? userId;
  String? title;
  String? description;
  String? noteStatus;
  DateTime? createdAt;
  int? v;

  NoteListDataModel({
    this.id,
    this.userId,
    this.title,
    this.description,
    this.noteStatus,
    this.createdAt,
    this.v,
  });

  factory NoteListDataModel.fromJson(Map<String, dynamic> json) => NoteListDataModel(
    id: json["_id"],
    userId: json["userId"],
    title: json["title"],
    noteStatus: json["noteStatus"],
    description: json["description"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "userId": userId,
    "noteStatus": noteStatus,
    "title": title,
    "description": description,
    "createdAt": createdAt?.toIso8601String(),
    "__v": v,
  };
}
