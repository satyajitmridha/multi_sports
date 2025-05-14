import 'package:flutter/material.dart';

class LeaderboardPage extends StatefulWidget {
  @override
  _LeaderboardPageState createState() => _LeaderboardPageState();
}

class _LeaderboardPageState extends State<LeaderboardPage> {
  List<Map<String, dynamic>> overallLeaderboard = [];
  List<Map<String, dynamic>> sportWiseLeaderboard = [];
  int currentPageOverall = 1;
  int currentPageSportWise = 1;
  final int itemsPerPage = 10;
  bool isLoadingOverall = false;
  bool isLoadingSportWise = false;

  @override
  void initState() {
    super.initState();
    _fetchOverallLeaderboard();
    _fetchSportWiseLeaderboard();
  }

  void _fetchOverallLeaderboard() async {
    setState(() {
      isLoadingOverall = true;
    });

    Future.delayed(Duration(seconds: 2), () {
      List<Map<String, dynamic>> newEntries = List.generate(itemsPerPage, (index) {
        int rank = ((currentPageOverall - 1) * itemsPerPage) + index + 1;
        return {
          "rank": rank,
          "name": "Player $rank",
          "score": (1000 - rank * 5).toString(),
          "details": "Achievements: Gold Medal, MVP, Top Scorer",
        };
      });

      setState(() {
        overallLeaderboard.addAll(newEntries);
        isLoadingOverall = false;
      });
    });
  }

  void _fetchSportWiseLeaderboard() async {
    setState(() {
      isLoadingSportWise = true;
    });

    Future.delayed(Duration(seconds: 2), () {
      List<Map<String, dynamic>> newEntries = List.generate(itemsPerPage, (index) {
        int rank = ((currentPageSportWise - 1) * itemsPerPage) + index + 1;
        return {
          "rank": rank,
          "name": "Sport Player $rank",
          "sport": "Sport ${rank % 5 + 1}",
          "score": (900 - rank * 4).toString(),
        };
      });

      setState(() {
        sportWiseLeaderboard.addAll(newEntries);
        isLoadingSportWise = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Leaderboard"),
          bottom: TabBar(
            tabs: [
              Tab(text: "Overall"),
              Tab(text: "Sport-wise"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildExpandableLeaderboardList(overallLeaderboard, isLoadingOverall, () {
              currentPageOverall++;
              _fetchOverallLeaderboard();
            }),
            _buildLeaderboardList(sportWiseLeaderboard, isLoadingSportWise, () {
              currentPageSportWise++;
              _fetchSportWiseLeaderboard();
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildExpandableLeaderboardList(List<Map<String, dynamic>> leaderboard, bool isLoading, VoidCallback loadMore) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: leaderboard.length + 1, // +1 for loading indicator
            itemBuilder: (context, index) {
              if (index == leaderboard.length) {
                return isLoading
                    ? Padding(
                        padding: EdgeInsets.all(10),
                        child: Center(child: CircularProgressIndicator()),
                      )
                    : SizedBox.shrink();
              }

              var player = leaderboard[index];
              return ExpansionTile(
                leading: CircleAvatar(
                  child: Text(player["rank"].toString()),
                  backgroundColor: Colors.blueAccent,
                ),
                title: Text(player["name"], style: TextStyle(fontWeight: FontWeight.bold)),
                trailing: Text("Score: ${player["score"]}", style: TextStyle(color: Colors.green)),
                children: [
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(player["details"], style: TextStyle(color: Colors.grey)),
                  ),
                ],
              );
            },
          ),
        ),
        if (!isLoading)
          ElevatedButton(
            onPressed: loadMore,
            child: Text("Load More"),
          ),
      ],
    );
  }

  Widget _buildLeaderboardList(List<Map<String, dynamic>> leaderboard, bool isLoading, VoidCallback loadMore) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: leaderboard.length + 1, // +1 for loading indicator
            itemBuilder: (context, index) {
              if (index == leaderboard.length) {
                return isLoading
                    ? Padding(
                        padding: EdgeInsets.all(10),
                        child: Center(child: CircularProgressIndicator()),
                      )
                    : SizedBox.shrink();
              }

              var player = leaderboard[index];
              return ListTile(
                leading: CircleAvatar(
                  child: Text(player["rank"].toString()),
                  backgroundColor: Colors.blueAccent,
                ),
                title: Text(player["name"], style: TextStyle(fontWeight: FontWeight.bold)),
                subtitle: player.containsKey("sport") ? Text("Sport: ${player["sport"]}") : null,
                trailing: Text("Score: ${player["score"]}", style: TextStyle(color: Colors.green)),
              );
            },
          ),
        ),
        if (!isLoading)
          ElevatedButton(
            onPressed: loadMore,
            child: Text("Load More"),
          ),
      ],
    );
  }
}
