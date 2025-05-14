import 'package:flutter/material.dart';
import 'package:multi_sports/themes.dart';
import 'package:multi_sports/screens/about.dart';


class StaticButtonGrid extends StatelessWidget {
  final List<ButtonConfig> buttons = [
    ButtonConfig(
        imagePath: 'assets/images/about.png',
        text: 'About',
        screen: About()),
    ButtonConfig(
        imagePath: 'assets/images/copd.png',
        text: 'COPD',
        screen: About()),
    ButtonConfig(
        imagePath: 'assets/images/committee.png',
        text: 'Committee',
        screen: About()),
    ButtonConfig(
        imagePath: 'assets/images/sponsors.png',
        text: 'Sponsors',
        screen: About()),
    ButtonConfig(
        imagePath: 'assets/images/owners_team.png',
        text: 'Owners & Teams',
        screen: About()),
    ButtonConfig(
        imagePath: 'assets/images/statistic.png',
        text: 'Statistics',
        screen: About()),
    // ButtonConfig(
    //     imagePath: 'assets/images/notification.png',
    //     text: 'Notifications',
    //     screen: CommitteeScreen()),
    ButtonConfig(
        imagePath: 'assets/images/refree.png',
        text: 'Referee & Marshall',
        screen: About()),
    // ButtonConfig(
    //     imagePath: 'assets/images/res.png',
    //     text: 'Reserve Players',
    //     screen: ReservePlayersScreen()),
    // ButtonConfig(
    //     imagePath: 'assets/images/playstore.png',
    //     text: 'Version 2.04',
    //     screen: CommitteeScreen()),
    ButtonConfig(
        imagePath: 'assets/images/people.png',
        text: 'Play Along',
        screen: About()),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          childAspectRatio: 1.0, // Ensures buttons are square
        ),
        itemCount: buttons.length,
        itemBuilder: (context, index) {
          final button = buttons[index];
          return Card(
            elevation: 6,
            margin: const EdgeInsets.all(8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0), // Rounded corners
            ),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          button.screen), // Navigate to the respective screen
                );
              },
              child: Padding(
                padding:
                    const EdgeInsets.all(8.0), // Padding around the content
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 40, // Reduced size for the icon
                      height: 40,
                      child: Image.asset(
                        button.imagePath,
                        fit: BoxFit.contain,
                        color: AppThemes.getBackground(), // Black icon color
                      ),
                    ),
                    const SizedBox(height: 8),
                    Expanded(
                      child: Center(
                        child: Text(
                          button.text,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class ButtonConfig {
  final String imagePath;
  final String text;
  final Widget screen; // Add a screen parameter to ButtonConfig

  ButtonConfig(
      {required this.imagePath, required this.text, required this.screen});
}
