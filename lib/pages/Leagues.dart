import 'package:flutter/material.dart';
import 'package:proto_match/models/League.dart';
import 'package:proto_match/styles.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:proto_match/widgets/LeagueWidget.dart';

class Leagues extends StatefulWidget {
  @override
  createState() => LeaguesState();
}

class LeaguesState extends State<Leagues> {
  PageController _pageController;
  List<League> _leagues;
  int currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
        viewportFraction: 1.0, initialPage: currentPage, keepPage: false);
    _getLeagues();
  }

  Future<Null> _getLeagues() async {
    var response = await http.get('http://quinielas.memoadian.com/api/leagues');

    if (response.statusCode == 200) {
      var result = json.decode(response.body);
      Iterable list = result;
      setState(() {
        _leagues = list.map((model) => League.fromJson(model)).toList();
        print(_leagues);
      });
    } else {
      throw Exception('Fallo al cargar los datos desde el servidor');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ligas'),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(bottom: 22),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 50, left: 10, right: 10),
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(text: 'Pro ', style: AppTheme.title1),
                      TextSpan(text: 'Match', style: AppTheme.title2),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20, left: 10, right: 10),
                child: Text(
                  'Una quiniela para que juegues contra gente de todo el mundo :D',
                  style: AppTheme.paragraph,
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                child: (_leagues != null) ? PageView.builder(
                  physics: ClampingScrollPhysics(),
                  itemBuilder: _leagueBuilder,
                  itemCount: _leagues.length,
                ) : Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _leagueBuilder(BuildContext context, int index) {
    return LeagueWidget(
      id: _leagues[index].id,
      image: _leagues[index].image,
      name: _leagues[index].name,
      colorBegin: int.parse(_leagues[index].color),
      colorEnd: int.parse(_leagues[index].colorEnd),
      pageController: _pageController,
      currentPage: 0,
    );
  }
}
