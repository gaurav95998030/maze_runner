


class LoginResponse {
  final String message;
  final String token;
  final Team team;

  LoginResponse({
    required this.message,
    required this.token,
    required this.team,
  });

  // Factory constructor to create an instance of LoginResponse from JSON
  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      message: json['message'],
      token: json['token'],
      team: Team.fromJson(json['team']),
    );
  }

  // Method to convert LoginResponse object back to JSON
  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'token': token,
      'team': team.toJson(),
    };
  }
}




class Team {
  final int id;
  final String teamname;
  final String teamlead;
  final String email;
  final String mobile;
  final int teamscore;
  final String? lastSolvedAt;

  Team({
    required this.id,
    required this.teamname,
    required this.teamlead,
    required this.email,
    required this.mobile,
    required this.teamscore,
    required this.lastSolvedAt,
  });

  // Factory constructor to create an instance of Team from JSON
  factory Team.fromJson(Map<String, dynamic> json) {
    return Team(
      id: json['id'],
      teamname: json['teamname'],
      teamlead: json['teamlead'],
      email: json['email'],
      mobile: json['mobile'],
      teamscore: json['teamscore'],
      lastSolvedAt: json['lastSolvedAt'],
    );
  }

  // Method to convert Team object back to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'teamname': teamname,
      'teamlead': teamlead,
      'email': email,
      'mobile': mobile,
      'teamscore': teamscore,
      'lastSolvedAt': lastSolvedAt,
    };
  }
}
