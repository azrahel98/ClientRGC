class GamesLine {
  String? idCount;
  String? hero;
  String? gameId;
  String? fecha;
  String? gameHost;
  String? duracion;

  String? k;
  String? d;
  String? a;

  String? status;

  String? urlPath;

  String fechaString() {
    return fecha!.substring(0, 10);
  }

  GamesLine.fromList(List<String> games, bool isDynamic) {
    if (isDynamic == false) {
      idCount = games[0].toString();
      gameId = games[2];
      fecha = games[3];
      gameHost = games[4];
      duracion = games[5];
      k = games[8];
      d = games[9];
      a = games[10];
      status = games[11];
      hero = games[12];
    } else {
      idCount = games[0].toString();
      gameId = games[2];
      fecha = games[3];
      gameHost = games[4];
      duracion = games[5];
      k = games[8];
      d = games[9];
      a = games[10];
      status = games[14];
      hero = games[15];
    }
  }
}
