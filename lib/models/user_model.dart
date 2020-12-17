import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({
    this.email,
    this.lastname,
    this.name,
    this.photo,
  });

  String email;
  String lastname;
  String name;
  String photo;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    email: json["email"],
    lastname: json["lastname"],
    name: json["name"],
    photo: json["photo"],
  );

  Map<String, dynamic> toJson() => {
    "email": email,
    "lastname": lastname,
    "name": name,
    "photo": photo,
  };
}
