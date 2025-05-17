import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:multi_sports/api/apis.dart';
import 'package:multi_sports/screens/owner_team/team_list.dart';

class OwnerList extends StatefulWidget {
  @override
  _OwnerList createState() => _OwnerList();
}

class _OwnerList extends State<OwnerList> {
  Map<String, dynamic> teamsData = {};

  @override
  void initState() {
    super.initState();
    fetchTeamsData();
  }

  Future<void> fetchTeamsData() async {
    try {
      final response = await http.get(Uri.parse(Apis.fetchOwnerAndTeamsDetails));

      if (response.statusCode == 200) {
        setState(() {
          teamsData = json.decode(response.body);
        });
      } else {
        setState(() {
          teamsData = {}; // Clear data on failure
        });
      }
    } catch (e) {
      print('Error fetching data: $e');
      setState(() {
        teamsData = {};
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (teamsData.isEmpty) {
      return Center(child: CircularProgressIndicator());
    }
    List<String> teamGroups = teamsData['team_and_participants_details'].keys.toList();
    return DefaultTabController(
      length: teamGroups.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Owners and Teams'),
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [const Color.fromARGB(255, 247, 74, 35), const Color.fromARGB(235, 247, 74, 35)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          bottom: TabBar(
            tabs: teamGroups.map((group) => Tab(text: group)).toList(),
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white60,
            indicator: BoxDecoration(
              color: const Color.fromARGB(255, 245, 111, 81),
              borderRadius: BorderRadius.circular(8),
            ),
            indicatorSize: TabBarIndicatorSize.tab,
          ),
        ),
        body: TabBarView(
          children: teamGroups.map((group) => _buildTeamList(group)).toList(),
        ),
      ),
    );
  }

  Widget _buildTeamList(String group) {
    List<dynamic> teams = teamsData['team_and_participants_details'][group] ?? [];
    
    return ListView.builder(
      itemCount: teams.length,
      itemBuilder: (context, index) {
        var team = teams[index];
        return Card(
          margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: ListTile(
            leading: team['image'] != null && team['image'].isNotEmpty 
                ? Image.network(team['the_image_link'], width: 80, height: 80)
                : Icon(Icons.group, size: 80),
            title: Text(team['team'] ?? 'No Team Name'),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Owner: ${team['owners'] ?? 'No Owner'}'),
                
                Text('Matches Played: ${team['total_played_by_the_team']}'),
              ],
            ),
            
            trailing: Icon(Icons.chevron_right),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TeamDetailsPage(team: team),
                ),
              );
            },
          ),
        );
      },
    );
  }
}