import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:proto_match/models/Journey.dart';

class Journeys extends StatelessWidget {

  Future<Journey> _getJourneys () async {
    var response = await http.get('http://quinielas.memoadian.com/api/journeys/1');

    if (response.statusCode == 200) {
      var result = json.decode(response.body);
      return result;
    } else {
      throw Exception('Fallo al cargar los datos desde el servidor');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center();
  }
}