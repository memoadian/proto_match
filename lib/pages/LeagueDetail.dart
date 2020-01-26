import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/Team.dart';

import 'AddQuiniela.dart';

class LeagueDetail extends StatefulWidget {
  @override
  _LeagueDetailState createState() => _LeagueDetailState();
}

class _LeagueDetailState extends State<LeagueDetail> {

  List<Team> _teams = List<Team>();
  String name = '';

  @override
  void initState() { 
    super.initState();
    _getTeams();
  }

  Future<Null> _getTeams() async {
    var response = await http.get('http://quinielas.memoadian.com/api/leagues/1');

    if (response.statusCode == 200) {
      var result = json.decode(response.body);

      Iterable list = result[0]['teams'];
      setState(() {
        name = result[0]['name'];
        _teams = list.map((model) => Team.fromJson(model)).toList();
      });
    } else {
      throw Exception('Fallo al cargar los datos desde el servidor');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
      ),
      body: _listTeams(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => (
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddQuiniela()),
          )
        ),
        child: Icon(Icons.add),
        backgroundColor: Colors.green,
      ),
    );
  }

  Widget _listTeams () {
    return ListView.builder(
      physics: AlwaysScrollableScrollPhysics(),
      itemCount: _teams.length,
      itemBuilder: _teamBuilder,
    );
  }

  Widget _teamBuilder (BuildContext context, int index) {
    return Column(
      children: <Widget> [
        ListTile(
          leading: (_teams[index].shield != null) ? Image.network(_teams[index].shield) : Icon(Icons.hourglass_empty, size: 46,),
          title: Text(_teams[index].name),
          subtitle: Text(_teams[index].stadium),
        ),
        Divider(
          indent: 15,
          endIndent: 15,
          color: Color.fromARGB(150, 44, 44, 44),
        ),
      ]
    );
  }
}