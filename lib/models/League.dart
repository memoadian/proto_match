class League {
  final int id;
  final String name;
  final int currentJourney;
  final String image;
  final String color;
  final String colorEnd;

  League({
    this.id,
    this.name,
    this.currentJourney,
    this.image,
    this.color,
    this.colorEnd
  });

  factory League.fromJson(Map<String, dynamic> json) {
    return League(
      id: json['id'],
      name: json['name'],
      currentJourney: json['current_journey'],
      image: json['image'],
      color: json['color'],
      colorEnd: json['color_end'],
    );
  }

  Map toMap () {
    var map = Map<String, dynamic>();
    map['id'] = id;
    map['name'] = name;
    map['image'] = image;
    return map;
  }
}