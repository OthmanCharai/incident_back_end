// To parse this JSON data, do
//
//     final agence = agenceFromJson(jsonString);

import 'dart:convert';


List<Agence> agenceFromJson(String str) => List<Agence>.from(json.decode(str).map((x) => Agence.fromJson(x)));

String agenceToJson(List<Agence> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Agence {
    Agence({
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
        required this.incidence,
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
    List<Incidence> incidence;

    factory Agence.fromJson(Map<String, dynamic> json) => Agence(
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
        incidence: List<Incidence>.from(json["incidence"].map((x) => Incidence.fromJson(x))),
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
        "incidence": List<dynamic>.from(incidence.map((x) => x.toJson())),
    };
}
class Incidence {
    Incidence({
        required this.id,
        required this.userId,
        required this.documentId,
        required this.noteId,
        required this.audioId,
        required this.videoId,
        required this.typeId,
        required this.localisationId,
        required this.inscriptionId,
        required this.createdAt,
        required this.updatedAt,
    });

    int id;
    int userId;
    int documentId;
    int noteId;
    int audioId;
    int videoId;
    int typeId;
    int localisationId;
    int inscriptionId;
    DateTime createdAt;
    DateTime updatedAt;

    factory Incidence.fromJson(Map<String, dynamic> json) => Incidence(
        id: json["id"],
        userId: json["user_id"],
        documentId: json["document_id"],
        noteId: json["note_id"],
        audioId: json["audio_id"],
        videoId: json["video_id"],
        typeId: json["type_id"],
        localisationId: json["localisation_id"],
        inscriptionId: json["inscription_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "document_id": documentId,
        "note_id": noteId,
        "audio_id": audioId,
        "video_id": videoId,
        "type_id": typeId,
        "localisation_id": localisationId,
        "inscription_id": inscriptionId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}