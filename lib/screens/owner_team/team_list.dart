import 'package:flutter/material.dart';

class TeamDetailsPage extends StatelessWidget {
  final Map<String, dynamic> team;

  const TeamDetailsPage({Key? key, required this.team}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text(team['team'] ?? 'Team Details'),
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
          bottom: const TabBar(
          tabs: [
            Tab(icon: Icon(Icons.people)), 
            Tab(icon: Icon(Icons.sports)), 
            Tab(icon: Icon(Icons.calendar_today)),
          ],
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          indicatorColor: Colors.white,
        ),
        ),
        body: TabBarView(
          children: [
            _buildTeamTabContent(),
            _buildMatchesTabContent(),
            _buildScheduleTabContent(),
          ],
        ),
      ),
    );
  }

  Widget _buildTeamTabContent() {
    return Column(
      children: [
        if (team['image'] != null && team['image'].isNotEmpty)
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Image.network(
                team['the_image_link'],
                width: 150,
                height: 150,
                fit: BoxFit.cover,
              ),
            ),
          ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'Team Members',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          child: _buildParticipantsList(team['participants_list'] ?? []),
        ),
      ],
    );
  }

  Widget _buildMatchesTabContent() {
    // Replace with your actual match data
   List<Map<String, dynamic>> matches = [
      {'opponent': 'Team A', 'date': '2023-05-15', 'result': 'Won 3-2'},
      {'opponent': 'Team B', 'date': '2023-05-22', 'result': 'Lost 1-4'},
      {'opponent': 'Team C', 'date': '2023-05-29', 'result': 'Draw 2-2'},
    ];
matches=[];

    return ListView.builder(
      itemCount: matches.length,
      itemBuilder: (context, index) {
        final match = matches[index];
        return Card(
          margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: ListTile(
            leading: Icon(Icons.sports_score, color: Colors.orange),
            title: Text('vs ${match['opponent']}'),
            subtitle: Text(match['date']),
            trailing: Chip(
            label: Text(
              match['result'],
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: _getResultColor(match['result']),
          ),
        ),
        );
      },
    );
  }

  Widget _buildScheduleTabContent() {
    // Replace with your actual schedule data
   List<Map<String, dynamic>> schedule = [
      {'opponent': 'Team D', 'date': '2023-06-05', 'time': '14:00', 'location': 'Main Court'},
      {'opponent': 'Team E', 'date': '2023-06-12', 'time': '16:00', 'location': 'Court 2'},
      {'opponent': 'Team F', 'date': '2023-06-19', 'time': '15:00', 'location': 'Main Court'},
    ];
schedule=[];
    return ListView.builder(
      itemCount: schedule.length,
      itemBuilder: (context, index) {
        final game = schedule[index];
        return Card(
          margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: ListTile(
            leading: Icon(Icons.calendar_today, color: Colors.blue),
            title: Text('vs ${game['opponent']}'),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${game['date']} at ${game['time']}'),
                Text('Location: ${game['location']}'),
              ],
            ),
            trailing: Icon(Icons.arrow_forward_ios, size: 16),
          ),
        );
      },
    );
  }

  Color _getResultColor(String result) {
    if (result.startsWith('Won')) return Colors.green;
    if (result.startsWith('Lost')) return Colors.red;
    return Colors.blue;
  }

  Widget _buildParticipantsList(List<dynamic> participants) {
    return ListView.builder(
      itemCount: participants.length,
      itemBuilder: (context, index) {
        var participant = participants[index];
        return InkWell(
          onTap: () {
            _showPlayerDetails(context, participant);
          },
          child: Card(
            margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: ListTile(
              leading: participant['participant_image'] != null && participant['participant_image'].isNotEmpty
                  ? CircleAvatar(
                      backgroundImage: NetworkImage(participant['participant_image']),
                    )
                  : CircleAvatar(
                      child: Icon(Icons.person),
                    ),
              title: Text(participant['participant_name'] ?? 'No Name'),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Handicap: ${participant['participant_handicap']}'),
                  Text('Played: ${participant['total_played_text']}'),
                ],
              ),
              trailing: participant['player_type'] != null && participant['player_type'].toString().isNotEmpty
                  ? Icon(Icons.star, color: Colors.amber)
                  : null,
            ),
          ),
        );
      },
    );
  }

  void _showPlayerDetails(BuildContext context, Map<String, dynamic> player) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: player['participant_image'] != null && player['participant_image'].isNotEmpty
                      ? NetworkImage(player['participant_image'])
                      : null,
                  child: player['participant_image'] == null || player['participant_image'].isEmpty
                      ? Icon(Icons.person, size: 50)
                      : null,
                ),
              ),
              SizedBox(height: 16),
              Center(
                child: Text(
                  player['participant_name'] ?? 'No Name',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 24),
              _buildDetailRow('Handicap', player['participant_handicap']?.toString() ?? 'N/A'),
              _buildDetailRow('Matches Played', player['total_played_text']?.toString() ?? 'N/A'),
              _buildDetailRow('Player Type', player['player_type']?.toString() ?? 'Regular'),
              SizedBox(height: 24),
              Center(
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('Close'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 247, 74, 35),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Text(
            '$label: ',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(value),
        ],
      ),
    );
  }
}