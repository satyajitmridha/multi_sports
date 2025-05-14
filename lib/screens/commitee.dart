import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Committee extends StatefulWidget {
  @override
  _Committee createState() => _Committee();
}

class _Committee extends State<Committee> {
  Map<String, dynamic>? committeeData;
  bool isLoading = true;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    fetchCommitteeData();
  }

  Future<void> fetchCommitteeData() async {
    try {
      final response = await http.get(Uri.parse('https://sports.forcempower.com/darts/show_committee_details.php'));
      
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['process_sts'] == 'YES') {
          setState(() {
            committeeData = data['committee_details'];
            isLoading = false;
          });
        } else {
          setState(() {
            isLoading = false;
            errorMessage = data['process_msg'] ?? 'Failed to load data';
          });
        }
      } else {
        setState(() {
          isLoading = false;
          errorMessage = 'Failed to load data: ${response.statusCode}';
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
        errorMessage = 'Error: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Committee', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: const Color.fromARGB(255, 247, 74, 35),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : errorMessage.isNotEmpty
              ? Center(child: Text(errorMessage))
              : SingleChildScrollView(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: _buildCommitteeSections(),
                  ),
                ),
    );
  }

  List<Widget> _buildCommitteeSections() {
    List<Widget> sections = [];
    
    if (committeeData != null) {
      committeeData!.forEach((role, members) {
        sections.add(
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Text(
                  role,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: const Color.fromARGB(255, 247, 74, 35),
                  ),
                ),
              ),
              GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.75,
                ),
                itemCount: members.length,
                itemBuilder: (context, index) {
                  final member = members[index];
                  return _buildMemberCard(member);
                },
              ),
              SizedBox(height: 24),
            ],
          ),
        );
      });
    }
    
    return sections;
  }

  Widget _buildMemberCard(Map<String, dynamic> member) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
              child: member['image'].isNotEmpty
                  ? Image.network(
                      member['image'],
                      fit: BoxFit.cover,
                      width: double.infinity,
                      errorBuilder: (context, error, stackTrace) => 
                          Icon(Icons.person, size: 80, color: Colors.grey),
                    )
                  : Icon(Icons.person, size: 80, color: Colors.grey),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text(
                  member['name'],
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 4),
                Text(
                  member['bottom_text'],
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}