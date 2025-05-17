import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'api/apis.dart';

class MatchSchedulePage extends StatefulWidget {
  @override
  _MatchSchedulePageState createState() => _MatchSchedulePageState();
}

class _MatchSchedulePageState extends State<MatchSchedulePage>
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
      final response = await http.get(Uri.parse(Apis.fetchMatchSchedule));
      
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
        
        title: Text('Match Schedule & Results'),
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
            color: Colors.green[50], // Change the color as needed
            margin: EdgeInsets.only(bottom: 16),
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      color: Colors.green[100], // Change the color as needed
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
                            color: Colors.green,
                          ),
                        ),
                        SizedBox(height: 8),
                        
                        if (match['result_data'] != null)
                        Container(
                          color: Colors.green[100],
                          child: ExpansionTile(
                            title: Text('Match Details'),
                            leading: Icon(Icons.info),
                            trailing: Icon(Icons.arrow_drop_down),
                            children: [
                              ...(match['result_data'] as Map<String, dynamic>)
                                  .entries
                                  .map((game) => ListTile(
                                        title: Text(game.value['title']),
                                        subtitle: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            if (game.value['team_1_participent_1'] != null && 
                                                game.value['team_1_participent_1'].isNotEmpty)
                                              Text('${match['team1']}: ${game.value['team_1_participent_1']}'),
                                            if (game.value['team_2_participent_1'] != null && 
                                                game.value['team_2_participent_1'].isNotEmpty)
                                              Text('${match['team2']}: ${game.value['team_2_participent_1']}'),
                                          ],
                                        ),
                                      ))
                                  .toList(),
                            ],
                          ),
                        ),
                       // Divider(),
                      
                      ],
                    ),
                ],
              ),
            ),
          );
        },
      );
   
  }
}