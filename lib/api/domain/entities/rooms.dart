class Rooms {
  String? name;
  int? key;
  Rooms({this.name, this.key});
  // Rooms.fromJson(Map<String, String> map) {
  //   this.name = map[0];
  //   this.key = map[1];
  // }

  Rooms.fromJson(Map<String, String> data)
      : name = data.keys.first,
        key = int.parse(data.values.first);
}
