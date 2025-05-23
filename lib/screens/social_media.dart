import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class SocialMediaGrid extends StatelessWidget {
  final List<Map<String, dynamic>> socialMedia = [
    {"icon": FontAwesomeIcons.twitter, "url": "https://twitter.com"},
    {"icon": FontAwesomeIcons.facebook, "url": "https://facebook.com"},
    {"icon": FontAwesomeIcons.instagram, "url": "https://www.instagram.com/royaldarts_rcgc"},
    {"icon": FontAwesomeIcons.linkedin, "url": "https://linkedin.com"},
    {"icon": FontAwesomeIcons.youtube, "url": "https://youtube.com"},
    {"icon": FontAwesomeIcons.whatsapp, "url": "https://whatsapp.com"},
  ];

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Social Media Links", style: TextStyle(color: Colors.white)),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: const Color.fromARGB(255, 247, 74, 35),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: socialMedia.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () => _launchURL(socialMedia[index]["url"]),
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Icon(
                    socialMedia[index]["icon"],
                    size: 40,
                    color: Colors.blueAccent,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
