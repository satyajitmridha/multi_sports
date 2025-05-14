import "player.dart";
import "dart:math";

class Match {
  final Function onFin;
  final int startScore, setLimit, legLimit;
  int active = 0, thisVisitThrown = 0;
  final List<String> names;
  late List<Player> players;

  Match(this.startScore, this.setLimit, this.legLimit, this.names, this.onFin) {
    players = [Player(name: names[0]), Player(name: names[1])];
    players[0].remaining = startScore;
    players[1].remaining = startScore;
    players[0].active = true;
    players[1].active = false;
  }

  void updateScore(int score) {
    Player a = players[active];
    Player i = players[(active + 1) % 2];

    a.totalThrown += 3; // TODO: Ask how many darts were thrown to checkout
    a.legThrown += 3;

    // Bust condition
    if (a.remaining - 1 <= score && a.remaining != score) {
      a.avg = 3 * a.totalScored / a.totalThrown;
      if (a.legThrown <= 9) {
        a.f9Thrown += 3;
        a.f9avg = 3 * a.f9Scored / a.f9Thrown;
      }
      active = (active + 1) % 2;
    } else {
      if (score == 180) {
        a.s180s += 1;
      } else if (score >= 140) {
        a.s140s += 1;
      } else if (score >= 100) {
        a.s100s += 1;
      } else if (score >= 80) {
        a.s80s += 1;
      }

      a.totalScored += score;
      a.avg = 3 * a.totalScored / a.totalThrown;
      if (a.legThrown <= 9) {
        a.f9Scored += score;
        a.f9Thrown += 3;
        a.f9avg = 3 * a.f9Scored / a.f9Thrown;
      }

      // Checkout condition
      if (a.remaining == score) {
        a.totalLegs += 1;
        a.legs += 1;
        a.legThrown = 0;
        i.legThrown = 0;
        a.maxCheckout = max(a.maxCheckout, score);
        if (a.legs == legLimit) {
          a.sets += 1;
          a.legs = 0;
          i.legs = 0;
          if (a.sets == setLimit) {
            onFin(this);
          }
        }
        a.remaining = startScore;
        i.remaining = startScore;
        active = (a.legs + a.sets + i.legs + i.sets) % 2;
      } else {
        // Valid score but not checkout
        a.remaining -= score;
        active = (active + 1) % 2;
      }
    }

    players[active].active = true;
    players[(active + 1) % 2].active = false;
  }
}
