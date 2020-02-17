import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'package:proto_match/models/Match.dart';

class AddQuiniela extends StatefulWidget {
  final int season;

  AddQuiniela(this.season);

  @override
  createState() => AddQuinielaState();
}

class AddQuinielaState extends State<AddQuiniela> {
  List<Match> _matches = List<Match>();
  List<int> _selectedRadios = List<int>();
  String _name = '';

  @override
  void initState() {
    super.initState();
    _getMatches();
    initializeDateFormatting();
  }

  Future<Null> _getMatches() async {
    print('http://quinielas.memoadian.com/api/journeys/${widget.season}');
    var response = await http
        .get('http://quinielas.memoadian.com/api/journeys/${widget.season}');

    if (response.statusCode == 200) {
      var result = json.decode(response.body);

      Iterable list = result['matches'];
      setState(() {
        _name = result['name'];
        _matches = list.map((model) => Match.fromJson(model)).toList();
        for (var i = 0; i <= _matches.length; i++) {
          _selectedRadios.add(0);
        }
      });
    } else {
      throw Exception('Fallo al cargar los datos desde el servidor');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(_name),
        ),
        body: Column(
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                itemCount: _matches.length,
                itemBuilder: _matchBuilder,
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 10, left: 20, top: 10, right: 20),
              child: InkWell(
                highlightColor: Colors.transparent,
                hoverColor: Colors.transparent,
                splashColor: Colors.transparent,
                child: Container(
                    padding: EdgeInsets.only(
                      bottom: 15,
                      left: 40,
                      top: 15,
                      right: 40
                    ),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Colors.green[400], Colors.green[700]]),
                      border: Border.all(
                        color: Colors.green[400],
                        width: 3,
                      ),
                      borderRadius: BorderRadius.circular(32),
                    ),
                    child: Text(
                      'Guardar Quiniela',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                ),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Confirmar'),
                        content: Text('Seguro que quieres guardar esta quiniela, ya no podrás editarla más tarde'),
                        actions: <Widget>[
                          FlatButton(
                            child: Text('Cancelar'),
                            onPressed: () => (Navigator.pop(context)),
                          ),
                          FlatButton(
                            child: Text('Aceptar'),
                            onPressed: () => (Navigator.pop(context)),
                          )
                        ],
                      );
                    }
                  );
                }
              ),
            ),
          ],
        ));
  }

  Widget _matchBuilder(BuildContext context, int index) {
    return Card(
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 5, bottom: 5),
            child: Text(
                '${_matches[index].local.name} vs ${_matches[index].visitor.name}'),
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: Radio(
                  value: 1,
                  activeColor: Colors.green,
                  groupValue: _selectedRadios[index],
                  onChanged: (value) {
                    setState(() {
                      _selectedRadios[index] = value;
                    });
                  },
                ),
              ),
              Expanded(
                child: Image.network(_matches[index].local.shield,
                    width: 48, height: 48),
              ),
              Expanded(
                child: Radio(
                  value: 2,
                  groupValue: _selectedRadios[index],
                  onChanged: (value) {
                    setState(() {
                      _selectedRadios[index] = value;
                    });
                  },
                ),
              ),
              Expanded(
                child: Image.network(_matches[index].visitor.shield,
                    width: 48, height: 48),
              ),
              Expanded(
                child: Radio(
                  value: 3,
                  activeColor: Colors.red,
                  groupValue: _selectedRadios[index],
                  onChanged: (value) {
                    setState(() {
                      _selectedRadios[index] = value;
                    });
                  },
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.only(top: 5, bottom: 5),
            child: Text(
                '${DateFormat('EEEE dd MMM H:mm', 'es_ES').format(DateTime.parse(_matches[index].dateMatch))}'),
          ),
        ],
      ),
    );
  }
}
