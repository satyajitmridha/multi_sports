import 'package:flutter/material.dart';

class DartScore extends StatefulWidget {
  @override
  _DartScore createState() => _DartScore();
}

class _DartScore extends State<DartScore> {
 

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text('Event', style: TextStyle(color: Colors.white)),
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
            // YouTube Player
      
            SizedBox(height: 20),
            Text(
              'title',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'description',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Handle event registration
              },
              child: Text('event for Event'),
            ),
          ],
        ),
      ),
    );
  }


}
