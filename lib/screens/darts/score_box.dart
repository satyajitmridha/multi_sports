import "package:flutter/material.dart";

class ScoreBox extends StatelessWidget {
  ScoreBox(this.scoreText);
  final String scoreText;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[900],
      child: Center(
        child: Text(
          scoreText,
          style: TextStyle(
            color: Colors.white,
            fontSize: 28,
          ),
        ),
      ),
    );
  }
}