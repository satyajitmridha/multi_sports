import 'package:flutter/material.dart';
import 'package:multi_sports/screens/about.dart';
import 'package:multi_sports/screens/lederboard/leader_board.dart';


class CustomBottomNavigationBar extends StatefulWidget {
  final String sponsorImageUrl;

  const CustomBottomNavigationBar({super.key, required this.sponsorImageUrl});

  @override
  _CustomBottomNavigationBarState createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 60.0,
          decoration: BoxDecoration(
            color: const Color(0xFF135841),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 10,
                offset: const Offset(0, -5),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              buildNavItem(
                context,
                Icons.bar_chart,
                'Leaderboard',
                () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LeaderboardPage(
                     // sponsorImageUrl: widget.sponsorImageUrl,
                    ),
                  ),
                ),
              ),
              buildNavItem(
                context,
                Icons.calendar_month,
                'Schedule',
                () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => About(),
                  ),
                ),
              ),
              buildNavItem(
                context,
                Icons.star,
                'Result',
                () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => About(),
                  ),
                ),
              ),
              buildNavItem(
                context,
                Icons.person,
                "Owner's Room",
                () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => About(),
                  ),
                ),
              ),
            ].map((item) {
              return Expanded(child: item);
            }).toList(),
          ),
        ),
        // Center(
        //   heightFactor: 0.5,
        //   child: Column(
        //     mainAxisSize: MainAxisSize.min,
        //     children: [
        //       FloatingActionButton(
        //         onPressed: () {},
        //         backgroundColor: Colors.white,
        //         child: Icon(
        //           Icons.sports_golf_rounded,
        //           color: AppThemes.getBackground(),
        //         ),
        //         elevation: 8.0,
        //       ),
        //       const SizedBox(height: 2),
        //       const Text(
        //         "Scoreboard",
        //         style: TextStyle(color: Colors.white, fontSize: 12),
        //       ),
        //     ],
        //   ),
        // ),
      ],
    );
  }

  Widget buildNavItem(
    BuildContext context,
    IconData icon,
    String label,
    VoidCallback onPressed,
  ) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          padding: EdgeInsets.zero,
          icon: Column(
            children: [
              Icon(icon, color: Colors.white),
              Text(
                label,
                style: TextStyle(color: Colors.white, fontSize: 10),
              ),
            ],
          ),
          onPressed: onPressed,
        ),
      ],
    );
  }
}
