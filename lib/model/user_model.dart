// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
    String? userid;
    String? name;
    String? email;
    int? age;
    String? phone;
    String? countryCode;
    String? image; 

    UserModel({
        this.userid,
        this.name,
        this.email,
        this.age,
        this.phone,
        this.countryCode,
        this.image,
    });

    factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        userid: json["userid"],
        name: json["name"],
        email: json["email"],
        age: json["age"],
        phone: json["phone"],
        countryCode: json["countryCode"],
        image: json["image"],
    );

    Map<String, dynamic> toJson() => {
        "userid": userid,
        "name": name,
        "email": email,
        "age": age,
        "phone": phone,
        "countryCode": countryCode,
        "image": image,
    };
}
