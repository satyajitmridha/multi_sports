import "package:flutter/material.dart";
import "keypad.dart";
import "score_box.dart";
import "playerCard.dart";
import "match.dart";

class MatchPage extends StatefulWidget {
  final Match match;
  const MatchPage(this.match, {super.key});

  @override
  _MatchPageState createState() => _MatchPageState();
}

class _MatchPageState extends State<MatchPage> {
  late Match match;
  String scoreBoxDisplay = "Score";

  @override
  void initState() {
    super.initState();
    match = widget.match;
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double spacing = width * 0.01;
    double keypadHeightFactor = 0.45;

    void updateScorebox(String buttonText) {
      String newText = scoreBoxDisplay;

      if (buttonText == "DEL") {
        if (newText == "Score" || newText.isEmpty) {
          return;
        } else {
          newText = newText.substring(0, newText.length - 1);
        }
      } else if (buttonText == "OK") {
        if (newText.isNotEmpty && newText != "Score") {
          int? parsedScore = int.tryParse(newText);
          if (parsedScore != null) {
            match.updateScore(parsedScore);
            newText = "Score";
          }
        }
      } else {
        if (newText == "Score") {
          newText = buttonText;
        } else {
          int? parsedScore = int.tryParse(newText + buttonText);
          if (parsedScore == null || parsedScore > 180 || newText.length >= 3) {
            return;
          }
          newText += buttonText;
        }
      }

      setState(() {
        scoreBoxDisplay = newText;
      });
    }

    Future<bool> _onBackPressed() async {
      return await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Are you sure you want to go back?"),
          content: const Text("All current progress in this match will be lost"),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text("NO"),
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text("YES"),
            ),
          ],
        ),
      ) ?? false;
    }

    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: const Color.fromARGB(255, 247, 74, 35),
          title: FittedBox(
            fit: BoxFit.fitWidth,
            child: Text(
              "${match.players[0].name.trim()} vs. ${match.players[1].name.trim()}    Sets: ${match.setLimit}, Legs: ${match.legLimit}",
            ),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(spacing),
          child: Column(
            children: <Widget>[
              Expanded(
                child: Container(
                  color: Colors.grey[900],
                  child: Padding(
                    padding: EdgeInsets.all(spacing * 4),
                    child: PlayerCardRow(match.players, spacing),
                  ),
                ),
              ),
              SizedBox(height: spacing),
              SizedBox(
                height: (height * keypadHeightFactor - 3 * spacing) / 4,
                child: ScoreBox(scoreBoxDisplay),
              ),
              SizedBox(height: spacing),
              SizedBox(
                height: height * keypadHeightFactor,
                child: Keypad(updateScorebox, spacing),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
