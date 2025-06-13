import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'darts/dart_scoring_page_new.dart';

class DartsMatchDetails extends StatelessWidget {
  final Map<String, dynamic> matchData;

  const DartsMatchDetails({Key? key, required this.matchData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final match = matchData['show_current_match_details'].length>0 ?matchData['show_current_match_details'][0]:[];
    //final resultData = match['result_data'].isNotEmpty ? match['result_data'] as Map<String, dynamic>:[] as Map<String, dynamic>;
    final resultData = match.isNotEmpty 
    ? match['result_data'] as Map<String, dynamic> 
    : <String, dynamic>{};
    final games = resultData.entries.toList();

    return Scaffold(
      appBar: AppBar(
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
        title: Text('Match Details'),
      ),
    //   body: SingleChildScrollView(
    //     child: Column(
    //       crossAxisAlignment: CrossAxisAlignment.start,
    //       children: [
    //         // Match Header
    //         _buildMatchHeader(match),
    //         Divider(thickness: 2),
            
    //         // Score Summary
    //         _buildScoreSummary(match),
    //         Divider(thickness: 2),
            
    //         // Games List
    //         Padding(
    //           padding: const EdgeInsets.all(12.0),
    //           child: Text(
    //             'Game Results',
    //             style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    //           ),
    //         ),
            
    //         ListView.builder(
    //           shrinkWrap: true,
    //           physics: NeverScrollableScrollPhysics(),
    //           itemCount: games.length,
    //           itemBuilder: (context, index) {
    //             return _buildGameCard(games[index].key, games[index].value);
    //           },
    //         ),
    //       ],
    //     ),
    //   ),
     body: matchData['show_current_match_details'].isNotEmpty
    ? ListView.builder(
        itemCount: matchData['show_current_match_details'].length,
        itemBuilder: (context, index) {
          final match = matchData['show_current_match_details'][index];
          return MatchCard(match: match);
        },
      ): Center(
        child: Text(
          'No match for today',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    
     );
  }

  Widget _buildMatchHeader(Map<String, dynamic> match) {
    final dateTime = DateTime.parse(match['date']);
    final formattedDate = DateFormat('MMM d, y').format(dateTime);
    final formattedTime = match['time'];
    
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${match['group']} • $formattedDate at $formattedTime',
            style: TextStyle(color: Colors.grey),
          ),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(match['team1_image_url']),
                  ),
                  SizedBox(height: 4),
                  Text(match['team1']),
                ],
              ),
              Column(
                children: [
                  Text(
                    match['live_score_text'],
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  Text(
                    match['match_status_text'],
                    style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(match['team2_image_url']),
                  ),
                  SizedBox(height: 4),
                  Text(match['team2']),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildScoreSummary(Map<String, dynamic> match) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            match['results'] != null ? match['results'].toString() : 'No Results',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text(
            'Score Board: ${match['score_board']}',
            style: TextStyle(fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget _buildGameCard(String gameName, Map<String, dynamic> gameData) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              gameData['title'],
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text('Game Type: ${gameData['game_type']}'),
            SizedBox(height: 12),
            
            // Team 1 Participants
            _buildParticipantRow(
              'Team 1',
              gameData['team_1_participents'],
              gameData['team_1_score'].toString(),
            ),
            
            // Team 2 Participants
            _buildParticipantRow(
              'Team 2',
              gameData['team_2_participents'],
              gameData['team_2_score'].toString(),
            ),
            
            SizedBox(height: 8),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  // Open game history web link
                },
                child: Text('View Game Details'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildParticipantRow(String teamLabel, String participants, String score) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              '$teamLabel:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            flex: 6,
            child: Text(participants),
          ),
          Expanded(
            flex: 1,
            child: Text(
              score,
              textAlign: TextAlign.end,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  
}


class MatchCard extends StatelessWidget {
  final dynamic match;

  const MatchCard({Key? key, required this.match}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('yyyy-MM-dd');
    final timeFormat = DateFormat('HH:mm');
    DateTime? date;
    try {
      date = dateFormat.parse(match['date']);
    } catch (e) {
      date = DateTime.now();
    }

    return Card(
      margin: EdgeInsets.all(8.0),
      child: Padding(
        padding: EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  match['group'],
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: const Color.fromARGB(255, 239, 127, 119),
                  ),
                ),
                Chip(
                  label: Text(
                    match['match_status_text'],
                    style: TextStyle(color: Colors.white),
                  ),
                  backgroundColor: match['match_status_text'] == 'Ongoing'
                      ? Colors.green
                      : Colors.grey,
                ),
              ],
            ),
            SizedBox(height: 8),
            Text(
              '${DateFormat('MMM d, yyyy').format(date)} at ${match['time']}',
              style: TextStyle(color: Colors.grey),
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TeamInfo(
                  name: match['team1'],
                  imageUrl: match['team1_image_url'],
                ),
                ScoreDisplay(
                  score: match['live_score_text'],
                  isCompleted: match['match_status_text'] == 'Game Over',
                ),
                TeamInfo(
                  name: match['team2'],
                  imageUrl: match['team2_image_url'],
                ),
              ],
            ),
            SizedBox(height: 8),
            if (match['results'] != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Text(
                  match['results'],
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ExpansionTile(
              title: Text('Match Details'),
              children: [
                ..._buildGameDetails(match['result_data']),
              ],
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildGameDetails(dynamic resultData) {
    List<Widget> widgets = [];
    resultData.forEach((gameKey, gameData) {
      widgets.add(
        GameDetailCard(gameData: gameData),
      );
    });
    return widgets;
  }
}

class TeamInfo extends StatelessWidget {
  final String name;
  final String imageUrl;

  const TeamInfo({Key? key, required this.name, required this.imageUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 30,
          backgroundImage: NetworkImage(imageUrl),
          backgroundColor: Colors.grey[100],
          onBackgroundImageError: (exception, stackTrace) => Icon(Icons.error),
        ),
        SizedBox(height: 8),
        Text(
          name,
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}

class ScoreDisplay extends StatelessWidget {
  final String score;
  final bool isCompleted;

  const ScoreDisplay(
      {Key? key, required this.score, required this.isCompleted})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'VS',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: isCompleted ? Colors.grey[200] : Colors.green[50],
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            score,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: isCompleted ? Colors.grey : Colors.green,
            ),
          ),
        ),
      ],
    );
  }
}


class GameDetailCard extends StatelessWidget {
  final dynamic gameData;

  const GameDetailCard({Key? key, required this.gameData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              gameData['title'],
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Type: ${gameData['game_type']}'),
                Text('Tee: ${gameData['tee']}'),
              ],
            ),
            SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Team 1 Participants',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 4),
                      ..._buildParticipantList(gameData['team_1_participents']),
                      SizedBox(height: 8),
                      Text(
                        'Score: ${gameData['team_1_score']}',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Team 2 Participants',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 4),
                      ..._buildParticipantList(gameData['team_2_participents']),
                      SizedBox(height: 8),
                      Text(
                        'Score: ${gameData['team_2_score']}',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            if (gameData['history_web_link'] != null &&
                gameData['history_web_link'].isNotEmpty)
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    //_navigateToAddScoreScreen(context);
                     Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => DartScoringPage(matchData: {
                        "match_id": 3,
                        "game_id": "game5",
                        "hole": 1,
                        "game_type": gameData['game_type'],
                      })),
                    );
                  },
                   style: TextButton.styleFrom(
                    backgroundColor: const Color.fromARGB(205, 242, 87, 17), // Set your desired background color here
                    foregroundColor: Colors.white, // Text color for better visibility
                  ),
                  child: Text('Add Score'),
                ),
              ),
          ],
        ),
      ),
    );
  }

  void _navigateToAddScoreScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddScoreScreen(
          gameTitle: gameData['title'],
          gameType: gameData['game_type'],
          team1Participants: gameData['team_1_participents'],
          team2Participants: gameData['team_2_participents'],
          currentTeam1Score: gameData['team_1_score'].toString(),
          currentTeam2Score: gameData['team_2_score'].toString(),
        ),
      ),
    );
  }

  List<Widget> _buildParticipantList(String participants) {
    List<String> parts = participants.split(';');
    return parts.map((part) {
      if (part.isEmpty || part == '()') return SizedBox.shrink();
      return Text(part.replaceAll('(', ' (').replaceAll(');', ')'));
    }).toList();
  }
}

class AddScoreScreen extends StatefulWidget {
  final String gameTitle;
  final String gameType;
  final String team1Participants;
  final String team2Participants;
  final String currentTeam1Score;
  final String currentTeam2Score;

  const AddScoreScreen({
    Key? key,
    required this.gameTitle,
    required this.gameType,
    required this.team1Participants,
    required this.team2Participants,
    required this.currentTeam1Score,
    required this.currentTeam2Score,
  }) : super(key: key);

  @override
  _AddScoreScreenState createState() => _AddScoreScreenState();
}

class _AddScoreScreenState extends State<AddScoreScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _team1ScoreController;
  late TextEditingController _team2ScoreController;

  @override
  void initState() {
    super.initState();
    _team1ScoreController = TextEditingController(text: widget.currentTeam1Score);
    _team2ScoreController = TextEditingController(text: widget.currentTeam2Score);
  }

  @override
  void dispose() {
    _team1ScoreController.dispose();
    _team2ScoreController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Score - ${widget.gameTitle}'),
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
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.gameTitle,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text('Game Type: ${widget.gameType}'),
                SizedBox(height: 24),
                
                // Team 1 Section
                Text(
                  'Team 1',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                ..._buildParticipantList(widget.team1Participants),
                SizedBox(height: 16),
                TextFormField(
                  controller: _team1ScoreController,
                  decoration: InputDecoration(
                    labelText: 'Team 1 Score',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a score';
                    }
                    if (int.tryParse(value) == null) {
                      return 'Please enter a valid number';
                    }
                    return null;
                  },
                ),
                
                SizedBox(height: 32),
                
                // Team 2 Section
                Text(
                  'Team 2',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                ..._buildParticipantList(widget.team2Participants),
                SizedBox(height: 16),
                TextFormField(
                  controller: _team2ScoreController,
                  decoration: InputDecoration(
                    labelText: 'Team 2 Score',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a score';
                    }
                    if (int.tryParse(value) == null) {
                      return 'Please enter a valid number';
                    }
                    return null;
                  },
                ),
                
                SizedBox(height: 32),
                
                Center(
                  child: ElevatedButton(
                    onPressed: _submitScores,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 12.0),
                      child: Text('Submit Scores'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildParticipantList(String participants) {
    List<String> parts = participants.split(';');
    return parts.map((part) {
      if (part.isEmpty || part == '()') return SizedBox.shrink();
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: Text(part.replaceAll('(', ' (').replaceAll(');', ')')),
      );
    }).toList();
  }

  void _submitScores() {
    if (_formKey.currentState!.validate()) {
      // Here you would typically send the scores to your backend
      // For now, we'll just show a success message and go back
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Scores updated successfully!')),
      );
      
      // After a short delay, go back to the previous screen
      Future.delayed(Duration(milliseconds: 1500), () {
        Navigator.pop(context);
      });
    }
  }
}