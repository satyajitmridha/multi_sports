import 'package:flutter/material.dart';
import '../api/api_response.dart';
import '../api/fetch_apis.dart'; // Adjust the import based on your project structure
import '../api/apis.dart'; // Adjust the import based on your project structure
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';


class Event extends StatefulWidget {
  @override
  _EventScreenState createState() => _EventScreenState();
}

class _EventScreenState extends State<Event> {

    late Future<ApiResponse> futureEventDetails;

  @override
  void initState() {
    super.initState();
    futureEventDetails = fetchEventDetails();
  }

  Future<ApiResponse> fetchEventDetails() async {
  final response = await http.get(
    Uri.parse(Apis.showEvent),
  );

  if (response.statusCode == 200) {
    // If the server returns a 200 OK response, parse the JSON
    return ApiResponse.fromJson(json.decode(response.body));
  } else {
    // If the server did not return a 200 OK response, throw an exception
    throw Exception('Failed to load event details');
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Event Details'),
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
      ),
      body: FutureBuilder<ApiResponse>(
        future: futureEventDetails,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (snapshot.hasData) {
            final events = snapshot.data!.eventDetails;
            return ListView.builder(
              padding: EdgeInsets.all(16),
              itemCount: events.length,
              itemBuilder: (context, index) {
                final event = events[index];
                return Card(
                  margin: EdgeInsets.only(bottom: 16),
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (event.eventImage.isNotEmpty)
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              event.eventImage,
                              height: 180,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                        SizedBox(height: 16),
                        Text(
                          event.eventName,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            Icon(Icons.calendar_today, size: 16),
                            SizedBox(width: 8),
                            Text(
                              event.dateForHeading,
                              style: TextStyle(fontSize: 14),
                            ),
                            SizedBox(width: 16),
                            Icon(Icons.access_time, size: 16),
                            SizedBox(width: 8),
                            Text(
                              event.time,
                              style: TextStyle(fontSize: 14),
                            ),
                          ],
                        ),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            Icon(Icons.location_on, size: 16),
                            SizedBox(width: 8),
                            Text(
                              event.locationName,
                              style: TextStyle(fontSize: 14),
                            ),
                          ],
                        ),
                        if (event.description.isNotEmpty) ...[
                          SizedBox(height: 8),
                          Text(
                            event.description,
                            style: TextStyle(fontSize: 14),
                          ),
                        ],
                        SizedBox(height: 16),
                        if (event.locationOnMap.isNotEmpty)
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color.fromARGB(255, 247, 74, 35),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              onPressed: () async{
                                // Open map link
                                  try {
                                    final Uri url = Uri.parse(event.locationOnMap);
                                    if (await canLaunchUrl(url)) {
                                      await launchUrl(url);
                                    } else {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text('Could not launch maps')),
                                      );
                                    }
                                  } catch (e) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text('Error opening maps: $e')),
                                    );
                                  }
                              },
                              child: Text('View on Map'),
                            ),
                          ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
          return Center(child: Text("No events found"));
        },
      ),
    );
  }
  @override
  void dispose() {
    super.dispose();
  }
}
