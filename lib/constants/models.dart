// To parse this JSON data, do
//
//     final messageResponseModel = messageResponseModelFromJson(jsonString);

import 'dart:convert';

MessageResponseModel messageResponseModelFromJson(String str) => MessageResponseModel.fromJson(json.decode(str));

String messageResponseModelToJson(MessageResponseModel data) => json.encode(data.toJson());

class MessageResponseModel {
  String? message;
  String? error;
  int? statusCode;

  MessageResponseModel({
    this.message,
    this.error,
    this.statusCode,
  });

  factory MessageResponseModel.fromJson(Map<String, dynamic> json) => MessageResponseModel(
    message: json["message"],
    error: json["error"],
    statusCode: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "error": error,
    "status": statusCode,
  };
}
