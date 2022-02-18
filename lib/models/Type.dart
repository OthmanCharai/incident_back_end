// To parse this JSON data, do
//
//     final type = typeFromJson(jsonString);

import 'dart:convert';

List<Type> typeFromJson(String str) => List<Type>.from(json.decode(str).map((x) => Type.fromJson(x)));

String typeToJson(List<Type> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Type {
    Type({
        required this.id,
        required this.name,
        required this.createdAt,
        required this.updatedAt,
    });

    int id;
    String name;
    DateTime createdAt;
    DateTime updatedAt;

    factory Type.fromJson(Map<String, dynamic> json) => Type(
        id: json["id"],
        name: json["name"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}
