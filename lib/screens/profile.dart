import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class Profile extends StatefulWidget {
  @override
  _Profile createState() => _Profile();
}

class _Profile extends State<Profile> {



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text('Profile', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      backgroundColor: const Color.fromARGB(255, 247, 74, 35),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        
        child: Column(
          
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
          
            Container(
              height: 200,
              width: 200,
              margin: EdgeInsets.only(bottom: 20, top: 20, left: 20, right: 20),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(
                      'https://picsum.photos/250?image=9', // Replace with your image URL
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'User Name',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              
            ),
           
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Handle event registration
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red, // Change this to your desired color
              ),
              child: Text('Logout', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
              
            ),
            SizedBox(height: 5),
            ElevatedButton(
              onPressed: () {
                // Handle event registration
              },
              child: Text('Delete Account'),
            ),
          ],
        ),
      ),
    );
  }

 
}
