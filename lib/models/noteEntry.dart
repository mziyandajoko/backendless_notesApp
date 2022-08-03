class NoteEntry {
  Map<dynamic, dynamic> notes;
  // String email;
  String username;
  String? objectId;
  DateTime? created;
  DateTime? updated;

  NoteEntry({
    required this.notes,
    required this.username,
    // required this.email,
    this.objectId,
    this.created,
    this.updated,
  });

  Map<String, Object?> toJson() => {
        // 'email': email,
        'notes': notes,
    'username': username,
    'created': created,
        'updated': updated,
        'objectId': objectId,
      };

  static NoteEntry fromJson(Map<dynamic, dynamic>? json) => NoteEntry(
        // email: json!['email'] as String,
    username: json!['username'] as String,
    notes: json['notes'] as Map<dynamic, dynamic>,
    objectId: json['objectId'] as String,
    created: json['created'] as DateTime,
  );
}
