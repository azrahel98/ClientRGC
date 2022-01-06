class GlobalStatus {
  final String? room;
  final int? rank;
  final int? kills;
  final int? deaths;
  final int? assits;
  final int? gamesWind;
  final int? gamesLoss;
  final int? points;

  GlobalStatus.fromList(List<String> games)
      : kills = int.parse(games[4]),
        deaths = int.parse(games[5]),
        assits = int.parse(games[6]),
        points = int.parse(games[7]),
        gamesWind = int.parse(games.last),
        rank = int.parse(games[3]),
        gamesLoss = int.parse(games[8]),
        room = 'Peru';

  int countGames() {
    return gamesWind! + gamesLoss!;
  }

  int countScore() {
    return kills! + deaths! + assits!;
  }
}
