// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'dart:convert';

LoginModel loginModelFromJson(String str) =>
    LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  User? user;
  List<dynamic>? menu;
  String? token;
  bool? success;
  String? message;

  LoginModel({
    this.user,
    this.menu,
    this.token,
    this.success,
    this.message,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        menu: json["menu"] == null
            ? []
            : List<dynamic>.from(json["menu"]!.map((x) => x)),
        token: json["token"],
        success: json["success"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "user": user?.toJson(),
        "menu": menu == null ? [] : List<dynamic>.from(menu!.map((x) => x)),
        "token": token,
        "success": success,
        "message": message,
      };
}

class User {
  UserType? userType;
  String? email;
  String? id;
  String? franchise;
  String? username;

  User({
    this.userType,
    this.email,
    this.id,
    this.franchise,
    this.username,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        userType: json["userType"] == null
            ? null
            : UserType.fromJson(json["userType"]),
        email: json["email"],
        id: json["_id"],
        franchise: json["franchise"],
        username: json["username"],
      );

  Map<String, dynamic> toJson() => {
        "userType": userType?.toJson(),
        "email": email,
        "_id": id,
        "franchise": franchise,
        "username": username,
      };
}

class UserType {
  String? id;
  String? role;
  String? roleDisplayName;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  UserType({
    this.id,
    this.role,
    this.roleDisplayName,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory UserType.fromJson(Map<String, dynamic> json) => UserType(
        id: json["_id"],
        role: json["role"],
        roleDisplayName: json["roleDisplayName"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "role": role,
        "roleDisplayName": roleDisplayName,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
      };
}
