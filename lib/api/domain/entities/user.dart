class User {
  String? nickname;
  String? country;
  String? profileLink;
  String? rgcId;

  User({this.country, this.nickname, this.profileLink, this.rgcId});

  User.fromList(List<String> user)
      : country = user[2].toString(),
        rgcId = user[1].toString(),
        profileLink = user.last.trim(),
        nickname = user[3].toString();
}
