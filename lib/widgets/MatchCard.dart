import 'package:flutter/material.dart';
import '/themes.dart';
import 'dart:io';
import 'package:intl/intl.dart';


class MatchCard extends StatelessWidget {
  final String matchNo;
  final String logoA;
  final String teamA;
  final String logoB;
  final String teamB;
  final String date;
  final String time;
  final bool showResult;
  final String? result;

  const MatchCard({
    Key? key,
    required this.matchNo,
    required this.logoA,
    required this.teamA,
    required this.logoB,
    required this.teamB,
    required this.date,
    required this.time,
    this.showResult = false,
    this.result,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Format the date
    final formattedDate = _formatDate(date);

    return Card(
      color: Colors.white,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 8,
      shadowColor: Colors.black45,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.brown, Colors.blueAccent],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(15.0),
                topRight: Radius.circular(15.0),
              ),
            ),
            child: Text(
              'Match No. $matchNo',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildTeamColumn(logoA, teamA),
                Image.asset(
                  'assets/images/vs.webp',
                  width: 80,
                  height: 80,
                ),
                _buildTeamColumn(logoB, teamB),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            decoration: BoxDecoration(
              border: Border(top: BorderSide(color: Colors.grey.shade300)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  formattedDate,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppThemes.getBackground(),
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 4),
                Text(
                  time,
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.black54,
                  ),
                  textAlign: TextAlign.center,
                ),
                if (showResult && result != null) ...[
                  const SizedBox(height: 10),
                  Text(
                    'Result: $result',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTeamColumn(String logo, String teamName) {
    return Expanded(
      child: Column(
        children: [
          Container(
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black45,
                  blurRadius: 10,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            child: CircleAvatar(
              radius: 25,
              backgroundColor: Colors.grey.shade200,
              // image: AssetImage("${logo}"),
              backgroundImage: logo.isNotEmpty ? NetworkImage(logo) : null,
              onBackgroundImageError: (_, __) => _buildPlaceholder(teamName),
              child: logo.isEmpty ? _buildPlaceholder(teamName) : null,
            ),
            // CircleAvatar(
            //       radius: 20,
            //       backgroundImage: widget.image.isNotEmpty
            //           ? NetworkImage(widget.image)
            //           : null,
            //       child: widget.image.isEmpty ? const Icon(Icons.person) : null,
            //     ),
          ),
          const SizedBox(height: 8),
          Text(
            teamName,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ],
      ),
    );
  }

  Widget _buildPlaceholder(String teamName) {
    return CircleAvatar(
      radius: 25,
      backgroundColor: Colors.grey,
      child: Text(
        teamName.isNotEmpty ? teamName[0] : '?',
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }

  String _formatDate(String date) {
    try {
      final parsedDate = DateTime.parse(date);
      final formatter = DateFormat('d MMMM yyyy'); // Example: 3 August 2020
      return formatter.format(parsedDate);
    } catch (e) {
      print('Error formatting date: $e');
      return date; // Fallback to original date if formatting fails
    }
  }
}
