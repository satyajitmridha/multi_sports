import "package:flutter/material.dart";
import "player.dart";
import "utils.dart";

class PlayerCard extends StatelessWidget {
  final Player player;
  const PlayerCard(this.player, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: player.active ? Colors.grey[600] : Colors.grey[900],
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            player.name,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20.0,
            ),
          ),
          Text(
            player.remaining.toString(),
            style: const TextStyle(color: Colors.white, fontSize: 38.0),
          ),
          c.containsKey(player.remaining)
              ? Text(
                  c[player.remaining]!,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                  ),
                )
              : Text(
                  " ",
                  style: TextStyle(
                    color: Colors.grey[900],
                    fontSize: 16.0,
                  ),
                ),
          Text(
            "Sets: ${player.sets}   Legs: ${player.legs}",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16.0,
            ),
          ),
          Text(
            "Avg: ${roundDouble(player.avg, 2)}",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16.0,
            ),
          ),
        ],
      ),
    );
  }
}

class PlayerCardRow extends StatelessWidget {
  final List<Player> players;
  final double spacing;

  const PlayerCardRow(this.players, this.spacing, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(child: PlayerCard(players[0])),
        SizedBox(width: spacing * 8),
        Expanded(child: PlayerCard(players[1])),
      ],
    );
  }
}
