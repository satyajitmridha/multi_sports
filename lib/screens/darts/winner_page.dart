import "dart:math";
import "package:confetti/confetti.dart";
import "package:flutter/material.dart";
import "match.dart";

class StatsRow extends StatelessWidget {
  final Match match;
  final String stat, title;

  const StatsRow(this.match, this.stat, this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          flex: 2,
          child: Center(
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ),
        Expanded(
          child: Center(
            child: Text(
              "${match.players[0].get(stat)}",
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ),
        Expanded(
          child: Center(
            child: Text(
              "${match.players[1].get(stat)}",
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ),
      ],
    );
  }
}

class WinnerPage extends StatefulWidget {
  final Match match;

  const WinnerPage(this.match, {super.key});

  @override
  _WinnerPageState createState() => _WinnerPageState();
}

class _WinnerPageState extends State<WinnerPage> {
  late ConfettiController _confettiController;
  late Match match;

  @override
  void initState() {
    super.initState();
    match = widget.match;
    _confettiController = ConfettiController(duration: const Duration(seconds: 2));
    _confettiController.play();
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const FittedBox(
          fit: BoxFit.fitWidth,
          child: Text("STATISTICS"),
        ),
      ),
      body: Column(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: ConfettiWidget(
              confettiController: _confettiController,
              blastDirection: pi / 2,
              maxBlastForce: 1,
              minBlastForce: 0.5,
              emissionFrequency: 0.5,
              numberOfParticles: 10,
              gravity: 0.2,
            ),
          ),
          Container(
            color: Colors.black,
            child: Center(
              child: Text(
                "FIRST TO ${match.setLimit} ${match.setLimit == 1 ? "SET" : "SETS"}",
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 24),
              ),
            ),
          ),
          const SizedBox(height: 10),
          StatsRow(match, "name", "Player"),
          const SizedBox(height: 10),
          StatsRow(match, "sets", "Sets"),
          const SizedBox(height: 10),
          StatsRow(match, "totalLegs", "Total Legs"),
          const SizedBox(height: 10),
          Container(
            color: Colors.black,
            child: const Center(
              child: Text(
                "SCORING",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24),
              ),
            ),
          ),
          const SizedBox(height: 10),
          StatsRow(match, "avg", "3 Dart Average"),
          const SizedBox(height: 10),
          StatsRow(match, "f9avg", "First 9 Darts Average"),
          const SizedBox(height: 10),
          StatsRow(match, "80s", "80+"),
          const SizedBox(height: 10),
          StatsRow(match, "100s", "100+"),
          const SizedBox(height: 10),
          StatsRow(match, "140s", "140+"),
          const SizedBox(height: 10),
          StatsRow(match, "180s", "180+"),
          const SizedBox(height: 10),
          StatsRow(match, "maxCheckout", "Highest Checkout"),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
