class TrucoConfig {
  final int playersCount;
  final int targetPoints;
  final bool florEnabled;
  final List<String> teamNames;

  TrucoConfig({
    required this.playersCount,
    required this.targetPoints,
    required this.florEnabled,
    required this.teamNames,
  });
}

class Player {
  String name;
  int score;

  Player({required this.name, this.score = 0});
}

class Team {
  String name;
  List<Player> players;
  int get totalScore => players.fold(0, (sum, p) => sum + p.score);

  Team({required this.name, required this.players});
}