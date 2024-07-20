// To parse this JSON data, do
//
//     final loginApiResponseModel = loginApiResponseModelFromJson(jsonString);

import 'dart:convert';

LoginApiResponseModel loginApiResponseModelFromJson(String str) => LoginApiResponseModel.fromJson(json.decode(str));

String loginApiResponseModelToJson(LoginApiResponseModel data) => json.encode(data.toJson());

class LoginApiResponseModel {
  String? authToken;
  UserDetails? user;

  LoginApiResponseModel({
    this.authToken,
    this.user,
  });

  factory LoginApiResponseModel.fromJson(Map<String, dynamic> json) => LoginApiResponseModel(
    authToken: json["authToken"],
    user: json["user"] == null ? null : UserDetails.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "authToken": authToken,
    "user": user?.toJson(),
  };
}

class UserDetails {
  String? id;
  String? username;
  String? firstName;
  String? lastName;
  int? phoneNumber;
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
