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