// To parse this JSON data, do
//
//     final allUserListApiResponseModel = allUserListApiResponseModelFromJson(jsonString);

import 'dart:convert';

AllUserListApiResponseModel allUserListApiResponseModelFromJson(String str) => AllUserListApiResponseModel.fromJson(json.decode(str));

String allUserListApiResponseModelToJson(AllUserListApiResponseModel data) => json.encode(data.toJson());

class AllUserListApiResponseModel {
  List<AllUserListApiDataModel>? data;
  int? count;
  String? message;
  int? status;

  AllUserListApiResponseModel({
    this.data,
    this.count,
    this.message,
    this.status,
  });

  factory AllUserListApiResponseModel.fromJson(Map<String, dynamic> json) => AllUserListApiResponseModel(
    data: json["data"] == null ? [] : List<AllUserListApiDataModel>.from(json["data"]!.map((x) => AllUserListApiDataModel.fromJson(x))),
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

class AllUserListApiDataModel {
  String? id;
  String? firstName;
  String? lastName;
  var phoneNumber;
  String? username;
  bool? verified;
  bool? isLoggedIn;

  AllUserListApiDataModel({
    this.id,
    this.firstName,
    this.lastName,
    this.phoneNumber,
    this.username,
    this.verified,
    this.isLoggedIn,
  });

  factory AllUserListApiDataModel.fromJson(Map<String, dynamic> json) => AllUserListApiDataModel(
    id: json["id"],
    firstName: json["firstName"],
    lastName: json["lastName"],
    phoneNumber: json["phoneNumber"],
    username: json["username"],
    verified: json["verified"],
    isLoggedIn: json["isLoggedIn"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "firstName": firstName,
    "lastName": lastName,
    "phoneNumber": phoneNumber,
    "username": username,
    "verified": verified,
    "isLoggedIn": isLoggedIn,
  };
}
