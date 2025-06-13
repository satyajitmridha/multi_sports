import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'api/apis.dart';
import 'package:url_launcher/url_launcher.dart';

class MatchResultPage extends StatefulWidget {
  @override
  _MatchResultPageState createState() => _MatchResultPageState();
}

class _MatchResultPageState extends State<MatchResultPage>
    with SingleTickerProviderStateMixin {
  Map<String, dynamic>? scheduleData;
  bool isLoading = true;
  String errorMessage = '';
  late TabController _tabController;
  List<String> groupNames = [];

  @override
  void initState() {
    super.initState();
      
      if (groupNames.isNotEmpty) {
        _tabController = TabController(length: groupNames.length, vsync: this);
      }
  
    fetchScheduleData();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> fetchScheduleData() async {
    try {
      groupNames = [];
      scheduleData = null;
      // Replace with your actual API endpoint
      final response = await http.get(Uri.parse(Apis.fetchMatchScheduleAndResults));
      
      if (response.statusCode == 200) {
        setState(() {
          scheduleData = json.decode(response.body);
          
          // Extract group names from the schedule data
          if (scheduleData != null && 
              scheduleData!['schedule_and_results_details'] != null) {
            groupNames = (scheduleData!['schedule_and_results_details'] as Map<String, dynamic>)
                .keys
                .toList();
          }
          
          
          if (groupNames.isNotEmpty) {
            _tabController = TabController(length: groupNames.length, vsync: this);
        }
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
          errorMessage = 'Failed to load data: ${response.statusCode}';
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
        errorMessage = 'Error: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
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
        
        title: Text('Match Results'),
        bottom: isLoading || errorMessage.isNotEmpty
            ? null
            : TabBar(
                controller: _tabController,
                isScrollable: true,
                tabs: groupNames.map((group) => Tab(text: group)).toList(),
                labelColor: Colors.white,
                unselectedLabelColor: Colors.white60,
                indicator: BoxDecoration(
                  color: const Color.fromARGB(255, 245, 111, 81),
                  borderRadius: BorderRadius.circular(8),
                ),
                indicatorSize: TabBarIndicatorSize.tab,
              ),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : errorMessage.isNotEmpty
              ? Center(child: Text(errorMessage))
              : TabBarView(
                  controller: _tabController,
                  children: groupNames.map((group) {
                    return buildGroupSchedule(group);
                  }).toList(),
                ),
    );
  }

  Widget buildGroupSchedule(String groupName) {
    final matches = (scheduleData!['schedule_and_results_details'] as Map<String, dynamic>)
        [groupName] as List<dynamic>;

     return 
      ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: matches.length,
        itemBuilder: (context, index) {
          final match = matches[index];
          return Card(
            color: Colors.red[50], // Change the color as needed
            margin: EdgeInsets.only(bottom: 16),
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      color: Colors.red[100], // Change the color as needed
                      padding: EdgeInsets.all(8), // Optional padding
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Game : ${match['id'] ?? 'No id'}',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Date : ${match['date'] ?? ''}'
                        ,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text('Time : ${match['time'] ?? ''}'
                        ,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Image.network(
                              match['team1_image_url'],
                              height: 50,
                              width: 50,
                              errorBuilder: (context, error, stackTrace) => 
                                  Icon(Icons.error),
                            ),
                            SizedBox(height: 8),
                            Text(
                              match['team1'],
                              textAlign: TextAlign.center,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        'vs',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Image.network(
                              match['team2_image_url'],
                              height: 50,
                              width: 50,
                              errorBuilder: (context, error, stackTrace) => 
                                  Icon(Icons.error),
                            ),
                            SizedBox(height: 8),
                            Text(
                              match['team2'],
                              textAlign: TextAlign.center,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  if (match['results'] != null && match['results'].isNotEmpty)
                    Column(
                      children: [
                        Divider(),
                        Text(
                          match['results'],
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          ),
                        ),
                        SizedBox(height: 8),
                        
                      //   if (match['result_data'] != null)
                      //   Container(
                      //     color: Colors.green[100],
                      //     child: ExpansionTile(
                      //       title: Text('Score Details'),
                      //       leading: Icon(Icons.info),
                      //       trailing: Icon(Icons.arrow_drop_down),
                      //       children: [
                      //         ...(match['result_data'] as Map<String, dynamic>)
                      //             .entries
                      //             .map((game) => ListTile(
                      //                   title: Text(game.value['title']),
                      //                   subtitle: Column(
                      //                     crossAxisAlignment: CrossAxisAlignment.start,
                      //                     children: [
                      //                       if (game.value['team_1_participent_1'] != null && 
                      //                           game.value['team_1_participent_1'].isNotEmpty)
                      //                         Text('${match['team1']}: ${game.value['team_1_participent_1']}'),
                      //                       if (game.value['team_2_participent_1'] != null && 
                      //                           game.value['team_2_participent_1'].isNotEmpty)
                      //                         Text('${match['team2']}: ${game.value['team_2_participent_1']}'),
                      //                     ],
                      //                   ),
                      //                 ))
                      //             .toList(),
                      //       ],
                      //     ),
                      //   ),
                      //  // Divider(),


                      if (match['result_data'] != null)
  Container(
    decoration: BoxDecoration(
      color: Colors.red[50],
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Colors.red[100]!),
    ),
    margin: EdgeInsets.only(top: 12),
    child: ExpansionTile(
      title: Text(
        'Match Details',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.red[800],
        ),
      ),
      leading: Icon(Icons.score, color: Colors.red[800]),
      trailing: Icon(Icons.expand_more, color: Colors.red[800]),
      children: [
        ...(match['result_data'] as Map<String, dynamic>)
            .entries
            .map((game) => Container(
                  padding: EdgeInsets.all(12),
                  margin: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.grey[50],
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey[200]!),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Game header
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            game.value['title'],
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                          if (game.value['team_1_score']?.isNotEmpty == true || 
                              game.value['team_2_score']?.isNotEmpty == true)
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                              decoration: BoxDecoration(
                                color: game.value['team_1_score']?.contains('WON') == true
                                    ? Colors.red[100]
                                    : game.value['team_2_score']?.contains('WON') == true
                                        ? Colors.red[100]
                                        : Colors.blue[100],
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                game.value['team_1_score']?.contains('WON') == true
                                    ? '${match['team1']} Won'
                                    : game.value['team_2_score']?.contains('WON') == true
                                        ? '${match['team2']} Won'
                                        : 'Draw',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: game.value['team_1_score']?.contains('WON') == true
                                      ? Colors.red[800]
                                      : game.value['team_2_score']?.contains('WON') == true
                                          ? Colors.red[800]
                                          : Colors.blue[800],
                                ),
                              ),
                            ),
                        ],
                      ),
                      SizedBox(height: 8),

                      // Team 1 participants
                      _buildParticipantRow(
                        teamName: match['team1'],
                        participants: game.value['team_1_participents']?.toString().split(';') ?? [],
                        isWinner: game.value['team_1_score']?.contains('WON') == true,
                      ),
                      SizedBox(height: 8),

                      // Team 2 participants
                      _buildParticipantRow(
                        teamName: match['team2'],
                        participants: game.value['team_2_participents']?.toString().split(';') ?? [],
                        isWinner: game.value['team_2_score']?.contains('WON') == true,
                      ),
                      SizedBox(height: 8),

                      // Score details
                      if (game.value['team_1_score']?.isNotEmpty == true || 
                          game.value['team_2_score']?.isNotEmpty == true)
                        Text(
                          'Result: ${game.value['team_1_score']?.isNotEmpty == true ? game.value['team_1_score'] : game.value['team_2_score']}',
                          style: TextStyle(fontSize: 12),
                        ),

                      // Scorecard link
                      if (game.value['history_web_link']?.isNotEmpty == true)
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () => _launchUrl(game.value['history_web_link']),
                            child: Text(
                              'View Scorecard',
                              style: TextStyle(fontSize: 12),
                            ),
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                              minimumSize: Size(0, 0),
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                          ),
                        ),
                    ],
                  ),
                ))
            .toList(),
      ],
    ),
  ),


                      
                      ],
                    ),
                ],
              ),
            ),
          );
        },
      );
   
  }

  // Helper widget for participant rows
Widget _buildParticipantRow({
  required String teamName,
  required List<String> participants,
  required bool isWinner,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        teamName,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: isWinner ? Colors.green[800] : Colors.black,
        ),
      ),
      SizedBox(height: 4),
      ...participants.map((participant) {
        final parts = participant.split('(');
        final name = parts[0];
        final handicap = parts.length > 1 ? parts[1].replaceAll(')', '') : '';

        return Padding(
          padding: const EdgeInsets.only(bottom: 4),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  name,
                  style: TextStyle(fontSize: 12),
                ),
              ),
              if (handicap.isNotEmpty)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    'HCP: $handicap',
                    style: TextStyle(fontSize: 10),
                  ),
                ),
            ],
          ),
        );
      }).toList(),
    ],
  );
}

// URL launcher function
Future<void> _launchUrl(String url) async {
  final Uri uri = Uri.parse(url);

  if (await canLaunchUrl(uri)) {
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  } else {
    throw 'Could not launch $url';
  }
}
}