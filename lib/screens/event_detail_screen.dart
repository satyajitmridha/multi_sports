import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class EventDetailScreen extends StatefulWidget {
  @override
  _EventDetailScreenState createState() => _EventDetailScreenState();
}

class _EventDetailScreenState extends State<EventDetailScreen> {
  late YoutubePlayerController _controller;
  late Map<String, dynamic> event;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    event = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    _controller = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(event['videoUrl'])!,
      flags: YoutubePlayerFlags(autoPlay: true, mute: false),
    );
  }

  // @override
  // void initState() {
  //   super.initState();
  //    event =
  //       ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

  //   _controller = YoutubePlayerController(
  //     initialVideoId: YoutubePlayer.convertUrlToId(event['videoUrl'])!,
  //     flags: YoutubePlayerFlags(
  //       autoPlay: true,
  //       mute: false,
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> event =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    return Scaffold(
      appBar: AppBar(title: Text(event['title']),
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
        ),),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // YouTube Player
            YoutubePlayer(
              controller: _controller,
              showVideoProgressIndicator: true,
            ),
            SizedBox(height: 20),
            Text(
              event['title'],
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              event['description'],
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            // ElevatedButton(
            //   onPressed: () {
            //     // Handle event registration
            //   },
            //   child: Text('Register for Event'),
            // ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}