import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DartScoringPage extends StatefulWidget {
  final Map<String, dynamic> matchData;
  const DartScoringPage({Key? key, required this.matchData}) : super(key: key);

  @override
  _DartScoringPageState createState() => _DartScoringPageState();
}

class _DartScoringPageState extends State<DartScoringPage> {
  int _team1Score = 501;
  int _team2Score = 501;
  int _currentRound = 1;
  List<String> _team1History = [];
  List<String> _team2History = [];
  String _currentInput = '';
  bool _isTeam1Turn = true;
  int _currentPlayerIndex = 0;
  String _currentMatchType = '';
  List<String> _team1Players = [];
  List<String> _team2Players = [];
  final ScrollController _team1ScrollController = ScrollController();
  final ScrollController _team2ScrollController = ScrollController();
  List<String> team_1_participents = [];
  List<String> team_2_participents = [];


  @override
  void initState() {
    super.initState();
    _initializeGame();
  }

  void _initializeGame() {
    final match = widget.matchData;
    _currentMatchType = match['game_type'] ?? 'Single';
    // team_1_participents = match['team_1_participents'] ?? [];
    // team_2_participents = match['team_2_participents'] ?? [];
    
    // Initialize players based on match type
    int playersPerTeam = 1;
    if (_currentMatchType == 'Double') playersPerTeam = 2;
    if (_currentMatchType == 'Triple') playersPerTeam = 3;
    
    _team1Players = List.generate(playersPerTeam, (index) => 'Team 1 Player ${index + 1}');
    _team2Players = List.generate(playersPerTeam, (index) => 'Team 2 Player ${index + 1}');
  }

  void _handleNumberPress(String number) {
    setState(() {
      if (_currentInput.length < 3) {
        _currentInput += number;
      }
    });
  }

  void _handleDelete() {
    setState(() {
      if (_currentInput.isNotEmpty) {
        _currentInput = _currentInput.substring(0, _currentInput.length - 1);
      }
    });
  }

  void _handleOK() {
    if (_currentInput.isEmpty) return;

    int score = int.tryParse(_currentInput) ?? 0;
    setState(() {
      if (_isTeam1Turn) {
        _team1Score -= score;
        _team1History.add('${_currentInput.padLeft(3)}  ${_team1Score.toString().padLeft(3)}');
         WidgetsBinding.instance.addPostFrameCallback((_) {
        _team1ScrollController.animateTo(
          _team1ScrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      });
      } else {
        _team2Score -= score;
        _team2History.add('${_currentInput.padLeft(3)}  ${_team2Score.toString().padLeft(3)}');
         WidgetsBinding.instance.addPostFrameCallback((_) {
        _team2ScrollController.animateTo(
          _team2ScrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      });
      }

      _currentInput = '';
      
      // Switch to next player
      _currentPlayerIndex++;
      
      // Check if we need to switch teams
      int playersPerTeam = _isTeam1Turn ? _team1Players.length : _team2Players.length;
      if (_currentPlayerIndex >= playersPerTeam) {
        _isTeam1Turn = !_isTeam1Turn;
        _currentPlayerIndex = 0;
      }
      
      _currentRound++;
    });
  }

  void _resetGame() {
    setState(() {
      _team1Score = 501;
      _team2Score = 501;
      _currentRound = 1;
      _team1History = [];
      _team2History = [];
      _currentInput = '';
      _isTeam1Turn = true;
      _currentPlayerIndex = 0;
      _initializeGame();
    });
  }

  String _getCurrentPlayerName() {
    if (_isTeam1Turn) {
      return _team1Players[_currentPlayerIndex];
    } else {
      return _team2Players[_currentPlayerIndex];
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: WillPopScope(
        onWillPop: () async {
          SystemChrome.setPreferredOrientations([
            DeviceOrientation.portraitUp,
            DeviceOrientation.portraitDown,
          ]);
          return true;
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text('Dart Scoring - ${widget.matchData['game_type']}'),
            flexibleSpace: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    const Color.fromARGB(255, 247, 74, 35),
                    const Color.fromARGB(235, 247, 74, 35)
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
            actions: [
              IconButton(
                icon: Icon(Icons.refresh),
                onPressed: _resetGame,
              ),
            ],
          ),
          body: Column(
            children: [
              // Team headers with player indicators
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        Text(
                          'Team 1',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        // ..._team1Players.map((player) => Text(
                        //   player,
                        //   style: TextStyle(
                        //     fontSize: 14,
                        //     color: _isTeam1Turn ? Colors.blue : Colors.grey,
                        //     fontWeight: _isTeam1Turn && 
                        //       _team1Players[_currentPlayerIndex] == player 
                        //       ? FontWeight.bold 
                        //       : FontWeight.normal
                        //   ),
                        // )).toList(),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          'Team 2',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        // ..._team2Players.map((player) => Text(
                        //   player,
                        //   style: TextStyle(
                        //     fontSize: 14,
                        //     color: !_isTeam1Turn ? Colors.blue : Colors.grey,
                        //     fontWeight: !_isTeam1Turn && 
                        //       _team2Players[_currentPlayerIndex] == player 
                        //       ? FontWeight.bold 
                        //       : FontWeight.normal
                        //   ),
                        // )).toList(),
                      ],
                    ),
                  ],
                ),
              ),
              
              // Current turn indicator
              Container(
                color: _isTeam1Turn ? Colors.blue[100] : Colors.red[100],
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Center(
                  child: Text(
                    "${_getCurrentPlayerName()}'s Turn",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
              ),
              
              // Score table header
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Table(
                        border: TableBorder.all(),
                        children: [
                          TableRow(
                            children: [
                              Center(child: Text('Scored', style: TextStyle(fontWeight: FontWeight.bold))),
                              Center(child: Text('To Go', style: TextStyle(fontWeight: FontWeight.bold))),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: Table(
                        border: TableBorder.all(),
                        children: [
                          TableRow(
                            children: [
                              Center(child: Text('Scored', style: TextStyle(fontWeight: FontWeight.bold))),
                              Center(child: Text('To Go', style: TextStyle(fontWeight: FontWeight.bold))),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              
              // Score history
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded( child: SingleChildScrollView(
                        controller: _team1ScrollController,
                        child: Table(
                          border: TableBorder.all(),
                          children: [
                            TableRow(
                              children: [
                                Center(child: Text('501')),
                                Center(child: Text('')),
                              ],
                            ),
                            ..._team1History.map((entry) {
                              var parts = entry.split('  ');
                              return TableRow(
                                children: [
                                  Center(child: Text(parts[0])),
                                  Center(child: Text(parts[1])),
                                ],
                              );
                            }).toList(),
                          ],
                        ),
                      ),
                      ),
                      SizedBox(width: 16),
                      Expanded( child: SingleChildScrollView(
                        controller: _team2ScrollController,
                        child: Table(
                          border: TableBorder.all(),
                          children: [
                            TableRow(
                              children: [
                                Center(child: Text('501')),
                                Center(child: Text('')),
                              ],
                            ),
                            ..._team2History.map((entry) {
                              var parts = entry.split('  ');
                              return TableRow(
                                children: [
                                  Center(child: Text(parts[0])),
                                  Center(child: Text(parts[1])),
                                ],
                              );
                            }).toList(),
                          ],
                        ),
                          ),
                      ),

                    
                    ],
                  ),
                ),
              ),
              
              // Current scores
              Container(
                padding: EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      ' ${_team1Score.toString().padLeft(3)}',
                      style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      ' ${_team2Score.toString().padLeft(3)}',
                      style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              
              // Current input display
              Container(
                padding: EdgeInsets.all(8),
                child: Text(
                  _currentInput.isEmpty ? '0' : _currentInput,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
              
              // Number pad
              GridView.count(
                shrinkWrap: true,
                crossAxisCount: 3,
                childAspectRatio: 1.5,
                padding: EdgeInsets.all(8),
                children: [
                  _buildNumberButton('1'),
                  _buildNumberButton('2'),
                  _buildNumberButton('3'),
                  _buildNumberButton('4'),
                  _buildNumberButton('5'),
                  _buildNumberButton('6'),
                  _buildNumberButton('7'),
                  _buildNumberButton('8'),
                  _buildNumberButton('9'),
                  _buildActionButton('DEL', _handleDelete, Colors.red),
                  _buildNumberButton('0'),
                  _buildActionButton('OK', _handleOK, Colors.green),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNumberButton(String number) {
    return Padding(
      padding: EdgeInsets.all(4),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
        ),
        onPressed: () => _handleNumberPress(number),
        child: Text(
          number,
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }

  Widget _buildActionButton(String text, VoidCallback onPressed, Color color) {
    return Padding(
      padding: EdgeInsets.all(4),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: Colors.white,
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}