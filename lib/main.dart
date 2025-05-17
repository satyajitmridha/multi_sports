import 'package:flutter/material.dart';
import 'package:multi_sports/match_result_page.dart';
import 'package:multi_sports/screens/lederboard/leader_board.dart';
import 'package:multi_sports/screens/owner_team/owner_list.dart';
import 'package:multi_sports/screens/profile.dart';
import 'screens/event_detail_screen.dart';
import 'screens/about.dart';
import 'screens/event.dart';
import 'screens/score_home.dart';
import 'screens/captain_room/loging_captain.dart';
import 'screens/hand_book.dart';
import 'screens/commitee.dart';
import 'screens/sponsors.dart';
import 'screens/owner_team/owner_list.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'match_schedule_page.dart';




void main() {
  runApp(SportsCarnivalApp());
}

class SportsCarnivalApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        fontFamily: 'Poppins',
        appBarTheme: AppBarTheme(
          elevation: 0,
          centerTitle: true,
          backgroundColor: Colors.transparent,
          iconTheme: IconThemeData(color: Colors.white),
          titleTextStyle: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 22,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        cardTheme: CardTheme(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          margin: EdgeInsets.all(8),
        ),
      ),
      home: DashboardScreen(),
      routes: {
        '/eventDetail': (context) => EventDetailScreen(),
      },
    );
  }
}

class DashboardScreen extends StatelessWidget {
  final List<Map<String, dynamic>> menuItems = [
    {'title': 'About', 'icon': Icons.info_outline, 'color': Colors.blueAccent},
    {'title': 'Handbook', 'icon': Icons.rule, 'color': Colors.orange},
    {'title': 'Committee', 'icon': Icons.person, 'color': Colors.green},
    {'title': 'Sponsors', 'icon': Icons.monetization_on, 'color': Colors.green},
    {'title': 'Owners and Teams', 'icon': Icons.group, 'color': Colors.purple},
    {'title': 'Gallery', 'icon': Icons.photo_library, 'color': Colors.pink},
    {'title': 'Play Along', 'icon': Icons.sports_esports, 'color': Colors.teal},
    {'title': 'Scan me', 'icon': Icons.qr_code_scanner, 'color': Colors.indigo},
    {'title': 'Events', 'icon': Icons.event, 'color': Colors.redAccent},
    {'title': 'Highlights', 'icon': Icons.highlight, 'color': Colors.amber},
    {'title': 'Captain & team', 'icon': Icons.group_add, 'color': Colors.cyan},
    {'title': 'Score', 'icon': Icons.score, 'color': Colors.lightBlue},
    {'title': 'Feedback', 'icon': Icons.feedback, 'color': Colors.deepOrange},
  ];

  final List<Map<String, dynamic>> carouselItems = [
    {
      'imageUrl': 'https://images.unsplash.com/photo-1540747913346-19e32dc3e97e?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',
      'videoUrl': 'https://www.youtube.com/shorts/Wj4X_ZaktJ8',
      'title': 'Cricket Tournament',
      'description': 'Annual inter-department cricket competition'
    },
    {
      'imageUrl': 'https://images.unsplash.com/photo-1574629810360-7efbbe195018?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',
      'videoUrl': 'https://www.youtube.com/shorts/Wj4X_ZaktJ8',
      'title': 'Football League',
      'description': 'Weekend football matches'
    },
    {
      'imageUrl': 'https://images.unsplash.com/photo-1552674605-db6ffd4facb5?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',
      'videoUrl': 'https://www.youtube.com/shorts/Wj4X_ZaktJ8',
      'title': 'Badminton Championship',
      'description': 'Singles and doubles matches'
    },
    {
      'imageUrl': 'https://images.unsplash.com/photo-1517649763962-0c623066013b?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',
      'videoUrl': 'https://www.youtube.com/shorts/Wj4X_ZaktJ8',
      'title': 'Athletics Meet',
      'description': 'Track and field events'
    },
    {
      'imageUrl': 'https://images.unsplash.com/photo-1546519638-68e109498ffc?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',
      'videoUrl': 'https://www.youtube.com/shorts/Wj4X_ZaktJ8',
      'title': 'Basketball Tournament',
      'description': '3-on-3 street basketball'
    },
  ];

  void onMenuItemTap(BuildContext context, String title) {
    switch (title) {
      case 'About':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => About()),
        );
        break;
      case 'Handbook':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Handbook()),
        );
        break;
      case 'Committee':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Committee()),
        );
        break;
      case 'Sponsors':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Sponsors()),
        );
        break;
      case 'Events':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Event()),
        );
        break;
      case 'Score':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Score()),
        );
        break;
      case 'Gallery':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => EventDetailScreen1()),
        );
        break;
      case 'Captain & team':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => EventDetailScreen1()),
        );
        break;
      case 'Play Along':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => EventDetailScreen1()),
        );
        break;
      case 'Scan me':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => EventDetailScreen1()),
        );
        break;
      case 'Highlights':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => EventDetailScreen1()),
        );
        break;
      case 'Captain room':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LogingCaptain()),
        );
        break;
      case 'Feedback':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => EventDetailScreen1()),
        );
        break;
      case 'Owners and Teams':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => OwnerList()),
        );
        break;
      default:
        print("$title tapped");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 220,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage('https://images.unsplash.com/photo-1540747913346-19e32dc3e97e?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        Colors.black.withOpacity(0.7),
                        Colors.transparent,
                      ],
                    ),
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        bottom: 20,
                        left: 20,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "CSC Sports Carnival",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Poppins',
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              "Celebrating sportsmanship",
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.9),
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            actions: [
              IconButton(
                icon: Badge(
                  label: Text("0"),
                  child: Icon(Icons.notifications, color: Colors.white),
                ),
                onPressed: () => print("Notifications Clicked"),
              ),
              IconButton(
                icon: Icon(Icons.person, color: Colors.white),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Profile()),
                  );
                },
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Featured Event Banner
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      gradient: LinearGradient(
                        colors: [Colors.deepPurple, Colors.purpleAccent],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.deepPurple.withOpacity(0.3),
                          blurRadius: 10,
                          offset: Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Featured Event",
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.8),
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          "Ladies Cricket Championship",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            Icon(Icons.calendar_today, color: Colors.white, size: 16),
                            SizedBox(width: 8),
                            Text(
                              "June 15-20, 2023",
                              style: TextStyle(color: Colors.white),
                            ),
                            Spacer(),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                foregroundColor: Colors.deepPurple,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                elevation: 0,
                              ),
                              onPressed: () {},
                              child: Text("Register"),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  
                  SizedBox(height: 24),
                  Text(
                    "Quick Access",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 12),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                childAspectRatio: 1,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: () => onMenuItemTap(context, menuItems[index]['title']),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            blurRadius: 10,
                            offset: Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: menuItems[index]['color'].withOpacity(0.1),
                            ),
                            child: Icon(
                              menuItems[index]['icon'],
                              color: menuItems[index]['color'],
                              size: 24,
                            ),
                          ),
                          SizedBox(height: 8),
                         AutoSizeText(
                          menuItems[index]['title'],
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                          maxLines: 1, // Ensures it stays on one line
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          minFontSize: 8, // Adjust font size dynamically
                        ),
                        ],
                      ),
                    ),
                  );
                },
                childCount: menuItems.length,
              ),
            ),
          ),
       
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.fromLTRB(16, 24, 16, 16),
              child: Text(
                "Highlights",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              height: 200,
              child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 16),
                scrollDirection: Axis.horizontal,
                itemCount: carouselItems.length,
                itemBuilder: (context, index) {
                  return Container(
                    width: 280,
                    margin: EdgeInsets.only(right: 16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          blurRadius: 10,
                          offset: Offset(0, 5),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          Image.network(
                            carouselItems[index]['imageUrl'],
                            fit: BoxFit.cover,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                                colors: [
                                  Colors.black.withOpacity(0.7),
                                  Colors.transparent,
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 16,
                            left: 16,
                            right: 16,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  carouselItems[index]['title'],
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  carouselItems[index]['description'],
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(0.9),
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  '/eventDetail',
                                  arguments: carouselItems[index],
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          SliverPadding(padding: EdgeInsets.only(bottom: 80)),
        ],
      ),
  
  bottomNavigationBar: Padding(
  padding: const EdgeInsets.all(16.0),
  child: Container(
    height: 70,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(24),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.1),
          blurRadius: 16,
          spreadRadius: 2,
          offset: Offset(0, 4),
        ),
      ],
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildBottomNavItem(
          icon: Icons.leaderboard_outlined,
          activeIcon: Icons.leaderboard,
          label: "Leaderboard",
          isActive: false,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LeaderboardPage()),
            );
          },
        ),
        _buildBottomNavItem(
          icon: Icons.schedule_outlined,
          activeIcon: Icons.schedule,
          label: "Schedule",
          isActive: false,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MatchSchedulePage()),
            );
          },
        ),
        _buildBottomNavItem(
          icon: Icons.star_border,
          activeIcon: Icons.star,
          label: "Results",
          isActive: false,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MatchResultPage()),
            );
          },
        ),
        _buildBottomNavItem(
          icon: Icons.meeting_room_outlined,
          activeIcon: Icons.meeting_room,
          label: "Captain",
          isActive: false,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LogingCaptain()),
            );
          },
        ),
      ],
    ),
  ),
),
    
    
    );
  }



Widget _buildBottomNavItem({
  required IconData icon,
  required IconData activeIcon,
  required String label,
  required bool isActive,
  required VoidCallback onTap,
}) {
  return InkWell(
    borderRadius: BorderRadius.circular(12),
    onTap: onTap,
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: isActive ? Colors.deepPurple.withOpacity(0.1) : Colors.transparent,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            isActive ? activeIcon : icon,
            color: isActive ? Colors.deepPurple : Colors.grey,
            size: 24,
          ),
          SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: isActive ? Colors.deepPurple : Colors.grey,
              fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
        ],
      ),
    ),
  );
}

  
}

class EventDetailScreen1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> event = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.black.withOpacity(0.4),
            ),
            child: Icon(Icons.arrow_back, color: Colors.white),
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 300,
              width: double.infinity,
              child: Stack(
                children: [
                  Image.network(
                    event['imageUrl'],
                    fit: BoxFit.cover,
                    height: 300,
                    width: double.infinity,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          Colors.black.withOpacity(0.7),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 20,
                    left: 20,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          event['title'],
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          event['description'],
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.9),
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Event Details",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 16),
                  _buildDetailRow(Icons.calendar_today, "Date", "June 15-20, 2023"),
                  _buildDetailRow(Icons.access_time, "Time", "9:00 AM - 5:00 PM"),
                  _buildDetailRow(Icons.location_on, "Venue", "Main Sports Complex"),
                  SizedBox(height: 24),
                  Text(
                    "About the Event",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam in dui mauris. Vivamus hendrerit arcu sed erat molestie vehicula. Sed auctor neque eu tellus rhoncus ut eleifend nibh porttitor.",
                    style: TextStyle(
                      fontSize: 16,
                      height: 1.5,
                    ),
                  ),
                  SizedBox(height: 32),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple,
                        padding: EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {},
                      child: Text(
                        "Register Now",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String title, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, color: Colors.deepPurple),
          SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
              Text(
                value,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}