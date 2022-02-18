// To parse this JSON data, do
//
//     final incident = incidentFromJson(jsonString);

import 'dart:convert';

List<Incident> incidentFromJson(String str) => List<Incident>.from(json.decode(str).map((x) => Incident.fromJson(x)));

String incidentToJson(List<Incident> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Incident {
    Incident({
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
        required this.user,
        required this.document,
        required this.note,
        required this.audio,
        required this.video,
        required this.localisation,
        required this.type,
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
    User user;
    Document document;
    Audio note;
    Audio audio;
    Audio video;
    Localisation localisation;
    TypeIncident type;

    factory Incident.fromJson(Map<String, dynamic> json) => Incident(
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
        user: User.fromJson(json["user"]),
        document: Document.fromJson(json["document"]),
        note: Audio.fromJson(json["note"]),
        audio: Audio.fromJson(json["audio"]),
        video: Audio.fromJson(json["video"]),
        localisation: Localisation.fromJson(json["localisation"]),
        type: TypeIncident.fromJson(json["type"]),
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
        "user": user.toJson(),
        "document": document.toJson(),
        "note": note.toJson(),
        "audio": audio.toJson(),
        "video": video.toJson(),
        "localisation": localisation.toJson(),
        "type": type.toJson(),
    };
}

class Audio {
    Audio({
        required this.id,
        required this.userId,
        required this.path,
        required this.createdAt,
        required this.updatedAt,
        required this.content,
    });

    int id;
    int userId;
    String path;
    DateTime createdAt;
    DateTime updatedAt;
    String content;

    factory Audio.fromJson(Map<String, dynamic> json) => Audio(
        id: json["id"],
        userId: json["user_id"],
        path: json["path"] == null ? null : json["path"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        content: json["content"] == null ? null : json["content"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "path": path == null ? null : path,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "content": content == null ? null : content,
    };
}

class Document {
    Document({
        required this.id,
        required this.userId,
        required this.photoCin,
        required this.cheque,
        required this.photo,
        required this.photoCheque,
        required this.createdAt,
        required this.updatedAt,
    });

    int id;
    int userId;
    String photoCin;
    String cheque;
    String photo;
    String photoCheque;
    DateTime createdAt;
    DateTime updatedAt;

    factory Document.fromJson(Map<String, dynamic> json) => Document(
        id: json["id"],
        userId: json["user_id"],
        photoCin: json["photo_cin"],
        cheque: json["cheque"],
        photo: json["photo"],
        photoCheque: json["photo_cheque"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "photo_cin": photoCin,
        "cheque": cheque,
        "photo": photo,
        "photo_cheque": photoCheque,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}

class Localisation {
    Localisation({
        required this.id,
        required this.agence,
        required this.ville,
        required this.tele1,
        required this.tele2,
        required this.tele3,
        required this.voiture,
        required this.matricule,
        required this.couleur,
        required this.createdAt,
        required this.updatedAt,
    });

    int id;
    String agence;
    String ville;
    String tele1;
    String tele2;
    String tele3;
    String voiture;
    String matricule;
    String couleur;
    DateTime createdAt;
    DateTime updatedAt;

    factory Localisation.fromJson(Map<String, dynamic> json) => Localisation(
        id: json["id"],
        agence: json["agence"],
        ville: json["ville"],
        tele1: json["tele_1"],
        tele2: json["tele_2"],
        tele3: json["tele_3"],
        voiture: json["voiture"],
        matricule: json["matricule"],
        couleur: json["couleur"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "agence": agence,
        "ville": ville,
        "tele_1": tele1,
        "tele_2": tele2,
        "tele_3": tele3,
        "voiture": voiture,
        "matricule": matricule,
        "couleur": couleur,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}

class TypeIncident {
    TypeIncident({
        required this.id,
        required this.name,
        required this.createdAt,
        required this.updatedAt,
    });

    int id;
    String name;
    DateTime createdAt;
    DateTime updatedAt;

    factory TypeIncident.fromJson(Map<String, dynamic> json) => TypeIncident(
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

class User {
    User({
        required this.id,
        required this.firstname,
        required this.lastname,
        required this.cin,
        required this.userableType,
        required this.userableId,
        required this.createdAt,
        required this.updatedAt,
    });

    int id;
    String firstname;
    String lastname;
    String cin;
    String userableType;
    int userableId;
    DateTime createdAt;
    DateTime updatedAt;

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        firstname: json["firstname"],
        lastname: json["lastname"],
        cin: json["cin"],
        userableType: json["userable_type"],
        userableId: json["userable_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "firstname": firstname,
        "lastname": lastname,
        "cin": cin,
        "userable_type": userableType,
        "userable_id": userableId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}
