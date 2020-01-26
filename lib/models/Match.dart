import 'package:proto_match/models/Team.dart';

class Match {
  final int id;
  final String dateMatch;
  final int localScore;
  final int visitorScore;
  final int isEnded;
  final Team local;
  final Team visitor;

  Match({
    this.id,
    this.dateMatch,
    this.localScore,
    this.visitorScore,
    this.isEnded,
    this.local,
    this.visitor
  });

  factory Match.fromJson(Map<String, dynamic> json) {
    return Match(
      id: json['id'],
      dateMatch: json['date_match'],
      localScore: json['local_score'],
      visitorScore: json['visitor_score'],
      isEnded: json['is_ended'],
      local: Team.fromJson(json['local']),
      visitor: Team.fromJson(json['visitor']),
    );
  }

  Map toMap () {
    var map = Map<String, dynamic>();
    map['id'] = id;
    map['dateMatch'] = dateMatch;
    map['localScore'] = localScore;
    map['visitorScore'] = visitorScore;
    map['isEnded'] = isEnded;
    map['local'] = local;
    map['visitor'] = visitor;
    return map;
  }
}