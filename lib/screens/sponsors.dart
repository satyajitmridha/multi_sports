import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:multi_sports/api/apis.dart';

class Sponsors extends StatefulWidget {
  @override
  _Sponsors createState() => _Sponsors();
}

class _Sponsors extends State<Sponsors> {
  List<dynamic> sponsors = [];
  bool _isLoading = true;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    fetchSponsors();
  }

  Future<void> fetchSponsors() async {
    try {
      final response = await http.get(Uri.parse(Apis.fetchSponsors)); // Replace with actual API URL

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          sponsors = data['sponsors_details'];
          _isLoading = false;
        });
      } else {
        setState(() {
          errorMessage = "Failed to fetch sponsors.";
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = "Error loading data: ${e.toString()}";
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sponsors', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: const Color.fromARGB(255, 247, 74, 35),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : errorMessage.isNotEmpty
              ? Center(child: Text(errorMessage, style: TextStyle(color: Colors.red)))
              : ListView.builder(
  padding: EdgeInsets.all(16),
  itemCount: sponsors.length,
  itemBuilder: (context, index) {
    final sponsor = sponsors[index];
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Full-width image on top
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
            child: Image.network(
              sponsor['image'],
              width: double.infinity, // Full width
              height: 200, // Adjust height as needed
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  sponsor['sponsor'],
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  sponsor['description'] ?? "",
                  style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  },
),

    );
  }
}
