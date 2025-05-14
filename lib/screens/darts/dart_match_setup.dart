import 'package:flutter/material.dart';
import 'match.dart';
import 'dart_score.dart';
import 'match_page.dart';
import 'winner_page.dart';
import 'dart:async';
import 'dart:math';

class DartsMatchSetup extends StatefulWidget {
  @override
  _DartsMatchSetup createState() => _DartsMatchSetup();
}

class _DartsMatchSetup extends State<DartsMatchSetup> {
 
 String _name1="", _name2="";
  int _sets=0, _legs=0, _startScore=0;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _buildName1() {
    return TextFormField(
      decoration: InputDecoration(labelText: "Player 1 name"),
      validator: (String? value) {
        if (value == null || value.isEmpty) {
          return "Name is Required";
        }
        return null;
      },
      onSaved: (String? value) {
        if (value != null) {
        _name1 = value.trim();
      }
      },
    );
  }

  Widget _buildName2() {
    return TextFormField(
      decoration: InputDecoration(labelText: "Player 2 name"),
      validator: (String? value) {
        if (value == null || value.isEmpty) {
          return "Name is Required";
        }
        return null;
      },
      onSaved: (String? value) {
        if (value != null) {
        _name2 = value.trim();
      }
      },
    );
  }

  Widget _buildStartScore() {
    return TextFormField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(labelText: "Starting score in each leg"),
      validator: (String? value) {
        if (value == null || value.isEmpty) {
          return "Please enter a value";
        }
        try {
          var x = int.parse(value);
          if (x < 2 || x > 10001) {
            return "Starting score must be between 2 and 10001";
          }
        } catch (e) {
          return "Starting score must be a whole number";
        }
        return null;
      },
      onSaved: (String? value) {
        if (value != null) {
        _startScore = int.parse(value);
      }
         
      },
    );
  }

  Widget _buildLegs() {
    return TextFormField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(labelText: "Legs needed to win each set"),
      validator: (String? value) {
        if (value == null || value.isEmpty) {
          return "Please enter a value";
        }

        try {
          var x = int.parse(value);
          if (x < 1 || x > 100) {
            return "Legs must be between 1 and 100";
          }
        } catch (e) {
          return "Legs must be a whole number";
        }
        return null;
      },
      onSaved: (String? value) {
        if (value != null) {
        _legs = int.parse(value);
        }
      },
    );
  }

  Widget _buildSets() {
    return TextFormField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(labelText: "Sets needed to win the match"),
      validator: (String? value) {
        if (value == null || value.isEmpty) {
          return "Please enter a value";
        }

        try {
          var x = int.parse(value);
          if (x < 1 || x > 100) {
            return "Sets must be between 1 and 100";
          }
        } catch (e) {
          return "Sets must be a whole number";
        }
        return null;
      },
      onSaved: (String? value) {
        if (value != null) {
        _sets = int.parse(value);
        }
      },
    );
  }

 Widget _buildStartButton() {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.green,
    ),
    child: const Text(
      "START",
      style: TextStyle(color: Colors.white, fontSize: 16),
    ),
    onPressed: () {
      if (_formKey.currentState?.validate() != true) {
        return;
      }
      _formKey.currentState?.save();

      void onFin(data) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => WinnerPage(data)),
        );
      }

      Match match = Match(_startScore, _sets, _legs, [_name1, _name2], onFin);

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MatchPage(match)),
      );
    },
  );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Match Setup"),
      ),
      body: Container(
        margin: EdgeInsets.all(32),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: ListView(
                  children: [
                    _buildName1(),
                    _buildName2(),
                    _buildStartScore(),
                    _buildLegs(),
                    _buildSets(),
                    SizedBox(height: 100),
                    _buildStartButton(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


}
