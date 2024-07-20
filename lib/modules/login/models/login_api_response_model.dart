// To parse this JSON data, do
//
//     final loginApiResponseModel = loginApiResponseModelFromJson(jsonString);

import 'dart:convert';

LoginApiResponseModel loginApiResponseModelFromJson(String str) => LoginApiResponseModel.fromJson(json.decode(str));

String loginApiResponseModelToJson(LoginApiResponseModel data) => json.encode(data.toJson());

class LoginApiResponseModel {
  String? authToken;
  UserDetails? user;
  String? message;
  int? statusCode;

  LoginApiResponseModel({
    this.authToken,
    this.user,
    this.message,
    this.statusCode,
  });

  factory LoginApiResponseModel.fromJson(Map<String, dynamic> json) => LoginApiResponseModel(
    authToken: json["authToken"],
    message: json["message"],
    statusCode: json["status"],
    user: json["user"] == null ? null : UserDetails.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "authToken": authToken,
    "message": message,
    "status": statusCode,
    "user": user?.toJson(),
  };
}

class UserDetails {
  String? id;
  String? username;
  String? firstName;
  String? lastName;
  String? phoneNumber;
  bool? verified;

  UserDetails({
    this.id,
    this.username,
    this.firstName,
    this.lastName,
    this.phoneNumber,
    this.verified,
  });

  factory UserDetails.fromJson(Map<String, dynamic> json) => UserDetails(
    id: json["_id"],
    username: json["username"],
    firstName: json["firstName"],
    lastName: json["lastName"],
    phoneNumber: json["phoneNumber"],
    verified: json["verified"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "username": username,
    "firstName": firstName,
    "lastName": lastName,
    "phoneNumber": phoneNumber,
    "verified": verified,
  };
}
