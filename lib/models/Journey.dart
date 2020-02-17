class Journey {
  final int id;
  final String name;

  Journey({
    this.id,
    this.name,
  });

  factory Journey.fromJson(Map<String, dynamic> json) {
    return Journey(
      id: json['id'],
      name: json['name'],
    );
  }

  Map toMap () {
    var map = Map<String, dynamic>();
    map['id'] = id;
    map['name'] = name;
    return map;
  }
}