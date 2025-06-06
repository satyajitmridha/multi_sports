import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'darts/dart_score.dart';
import 'darts/darts_home.dart';

class Score extends StatefulWidget {
  @override
  _Score createState() => _Score();
}

class _Score extends State<Score> {


  final List<Map<String, dynamic>> menuItems = [
    {'title': 'Darts', 'icon': Icons.info},
    {'title': 'Rules', 'icon': Icons.rule},

    
  ];

   onMenuItemTap(BuildContext context,String title) {
    switch (title) {
      case 'Darts':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DartsHome()),
        );
        break;
      case 'Scor':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Score()),
        );
        break;
      default:
        print("$title tapped");
    }
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text('About', style: TextStyle(color: Colors.white)),
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
          
            SizedBox(height: 20),
           
             SizedBox(height: 5),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        childAspectRatio: 1.2,
                        mainAxisSpacing: 5,
                        crossAxisSpacing: 5,
                      ),
                      itemCount: menuItems.length,
                      itemBuilder: (context, index) {
                        return Card(
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(10),
                            onTap: () => onMenuItemTap(context,menuItems[index]['title']),//print("${menuItems[index]['title']} tapped"),
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(menuItems[index]['icon'], size: 30, color: Colors.red),
                                  SizedBox(height: 8),
                                  Text(
                                    menuItems[index]['title'],
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 12),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    
           
          ],
        ),
      ),
    );
  }

 
}
