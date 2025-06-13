import 'dart:convert';
import 'package:http/http.dart' as http;
import 'apis.dart';
import 'api_response.dart';
import 'package:logger/logger.dart';

class ApiService {

  var logger = Logger();

  static Future<List<Map<String, dynamic>>> fetchCarouselItems() async {
    final response = await http.get(Uri.parse(Apis.showHighlight));

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return List<Map<String, dynamic>>.from(data);
    } else {
      throw Exception('Failed to load carousel items');
    }
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

  static Future<Map<String, dynamic>> verifyOtp(String mobileNumber, String otp) async {
    try {
      final response = await http.post(
        Uri.parse(Apis.wsMainLogin),
        body: {'mobile': mobileNumber, 'otp': otp},
      );

      return json.decode(response.body);
    } catch (e) {
      throw Exception('Failed to verify OTP: $e');
    }
  }

  static Future<Map<String, dynamic>> sendOtp(String mobileNumber) async {
    try {
      final response = await http.post(
        Uri.parse(Apis.wsMainLogin),
        body: {'username': mobileNumber, 'first_time_login': 'NO', 'device_id': 'reg_id', 'reg_id': 'YES', 'device_type': 'android'},
      );

      return json.decode(response.body);
    } catch (e) {
      throw Exception('Failed to send OTP: $e');
    }
  }

  static Future<Map<String, dynamic>> fetchToDayMatchDetails() async {
    try {
      final response = await http.post(
        Uri.parse(Apis.showToDaysMatchList),
        body: {'username': '', 'first_time_login': 'NO', 'device_id': 'reg_id', 'reg_id': 'YES', 'device_type': 'android'},
      );

      return json.decode(response.body);
    } catch (e) {
      throw Exception('Failed to send OTP: $e');
       // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) => DartsMatchDetails(matchData: matchData),
    //   ),
    // );
    }
  }

    static Future<Map<String, dynamic>> updateScoreDetails() async {
    try {
      final response = await http.post(
        Uri.parse(Apis.showToDaysMatchList),
        body: {'username': '', 'first_time_login': 'NO', 'device_id': 'reg_id', 'reg_id': 'YES', 'device_type': 'android'},
      );

      return json.decode(response.body);
    } catch (e) {
      throw Exception('Failed to send OTP: $e');
       // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) => DartsMatchDetails(matchData: matchData),
    //   ),
    // );
    }
  }

  Future<void> updatePoints() async {
  final url = Uri.parse("https://sports.forcempower.com/darts/update_points_against_hole_for_score_v2.php");

  final Map<String, String> body = {
    "match_id": "3",
    "game_id": "game5",
    "hole": "1",
    "logged_participants": "TEST",
    "updated_by": "TEST",
    "logged_team_id": "2",
    "team1_id": "2",
    "team1_participant1_id": "37",
    "team1_participant1_point": "1",
    "team1_participant2_id": "44",
    "team1_participant2_point": "2",
    "team1_participant3_id": "45",
    "team1_participant3_point": "3",
    "team2_id": "16",
    "team2_participant1_id": "27",
    "team2_participant1_point": "4",
    "team2_participant2_id": "46",
    "team2_participant2_point": "5",
    "team2_participant3_id": "47",
    "team2_participant3_point": "6"
  };

  try {
    final response = await http.post(url, body: body);
    
    if (response.statusCode == 200) {
      logger.i("Success: ${response.body}");
    } else {
      logger.w("Failed: ${response.statusCode}, ${response.body}");
    }
  } catch (error) {
    logger.e("Error updating points error");
  }
}


    static Future<Map<String, dynamic>> getScoreDetails(String match_id, String game_id, String my_team_id) async {
    try {
      final response = await http.post(
        Uri.parse(Apis.getScoreDetails),
        body: {'match_id': match_id, 'game_id': game_id, 'my_team_id': my_team_id},
      );
      

      return json.decode(response.body);
    } catch (e) {
      throw Exception('Failed to send OTP: $e');
     
    }
  }

}
