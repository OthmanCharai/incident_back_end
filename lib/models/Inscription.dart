// To parse this JSON data, do
//
//     final inscription = inscriptionFromJson(jsonString);

import 'dart:convert';

Inscription inscriptionFromJson(String str) => Inscription.fromJson(json.decode(str));

String inscriptionToJson(Inscription data) => json.encode(data.toJson());

class Inscription {
    Inscription({
        required this.data,
    });

    Data data;

    factory Inscription.fromJson(Map<String, dynamic> json) => Inscription(
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "data": data.toJson(),
    };
}

class Data {
    Data({
        required this.id,
        required this.agence,
        required this.ville,
        required this.address,
        required this.gerant,
        required this.gsm1,
        required this.gsm2,
        required this.gsm3,
        required this.fix,
        required this.phone,
        required this.email,
        required this.password,
        required this.emailVerifiedAt,
        required this.createdAt,
        required this.updatedAt,
    });

    int id;
    String agence;
    String ville;
    String address;
    String gerant;
    String gsm1;
    String gsm2;
    String gsm3;
    String fix;
    String phone;
    String email;
    String password;
    dynamic emailVerifiedAt;
    DateTime createdAt;
    DateTime updatedAt;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        agence: json["agence"],
        ville: json["ville"],
        address: json["address"],
        gerant: json["gerant"],
        gsm1: json["gsm_1"],
        gsm2: json["gsm_2"],
        gsm3: json["gsm_3"],
        fix: json["fix"],
        phone: json["phone"],
        email: json["email"],
        password: json["password"],
        emailVerifiedAt: json["email_verified_at"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "agence": agence,
        "ville": ville,
        "address": address,
        "gerant": gerant,
        "gsm_1": gsm1,
        "gsm_2": gsm2,
        "gsm_3": gsm3,
        "fix": fix,
        "phone": phone,
        "email": email,
        "password": password,
        "email_verified_at": emailVerifiedAt,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}
