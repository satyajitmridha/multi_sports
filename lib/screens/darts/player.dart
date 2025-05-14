import "utils.dart";

class Player {
  final String name;
  int remaining = 0, totalScored = 0, totalThrown = 0, f9Scored = 0, f9Thrown = 0, 
      sets = 0, legs = 0, totalLegs = 0, maxCheckout = 0, s180s = 0, s140s = 0, 
      s100s = 0, s80s = 0, legThrown = 0;
  bool active = false;
  double avg = 0.0, f9avg = 0.0;
  List<int> scores = [];

  Player({required this.name});

  Map<String, dynamic> _toMap() {
    return {
      "name": name,
      "sets": sets,
      "legs": legs,
      "totalLegs": totalLegs,
      "maxCheckout": maxCheckout,
      "avg": roundDouble(avg, 2),
      "f9avg": roundDouble(f9avg, 2),
      "80s": s80s,
      "100s": s100s,
      "140s": s140s,
      "180s": s180s,
    };
  }

  dynamic get(String propertyName) {
    var _mapRep = _toMap();
    if (_mapRep.containsKey(propertyName)) {
      return _mapRep[propertyName];
    }
    throw ArgumentError("Property not found: $propertyName");
  }
}
