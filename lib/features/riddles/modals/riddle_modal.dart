class Riddle {
  final String rid;
  final String description;
  final String riddlecode;
  final String location;

  Riddle({
    required this.rid,
    required this.description,
    required this.riddlecode,
    required this.location,
  });

  factory Riddle.fromJson(Map<String, dynamic> json) {
    return Riddle(
      rid: json['rid'] as String,
      description: json['description'] as String,
      riddlecode: json['riddlecode'] as String,
      location: json['location'] as String,
    );
  }
}

class RiddleResponse {
  final int id;
  final int teamId;
  final String riddleId;
  final int attempts;
  final int score;
  final String? lastSolvedAt; // Nullable
  final DateTime createdAt;
  final DateTime updatedAt;
  final Riddle riddle;

  RiddleResponse({
    required this.id,
    required this.teamId,
    required this.riddleId,
    required this.attempts,
    required this.score,
    this.lastSolvedAt, // Nullable
    required this.createdAt,
    required this.updatedAt,
    required this.riddle,
  });

  factory RiddleResponse.fromJson(Map<String, dynamic> json) {
    return RiddleResponse(
      id: json['id'] as int,
      teamId: json['teamId'] as int,
      riddleId: json['riddleId'] as String,
      attempts: json['attempts'] as int,
      score: json['score'] as int,
      lastSolvedAt: json['lastSolvedAt'] as String?, // Nullable
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      riddle: Riddle.fromJson(json['riddle'] as Map<String, dynamic>),
    );
  }
}
