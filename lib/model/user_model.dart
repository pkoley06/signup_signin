import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class UserModel {
  int? id;
  String? userName;
  String? password;
  String? confirmPassword;
  UserModel({
    this.id,
    this.userName,
    this.password,
    this.confirmPassword,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'userName': userName,
      'password': password,
      'confirmPassword': confirmPassword,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] != null ? map['id'] as int : null,
      userName: map['userName'] != null ? map['userName'] as String : null,
      password: map['password'] != null ? map['password'] as String : null,
      confirmPassword: map['confirmPassword'] != null
          ? map['confirmPassword'] as String
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
