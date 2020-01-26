class Team {
  final int id;
  final String name;
  final String shield;
  final String stadium;

  Team({
    this.id,
    this.name,
    this.shield,
    this.stadium,
  });

  factory Team.fromJson(Map<String, dynamic> json) {
    return Team(
      id: json['id'],
      name: json['name'],
      shield: json['shield'],
      stadium: json['stadium'],
    );
  }

  Map toMap () {
    var map = Map<String, dynamic>();
    map['id'] = id;
    map['name'] = name;
    map['shield'] = shield;
    map['stadium'] = stadium;
    return map;
  }
}