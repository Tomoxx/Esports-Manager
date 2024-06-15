import 'dart:collection';
import 'dart:convert';
import 'package:http/http.dart' as http;

class HttpService2 {
  final String apiUrl = 'http://10.0.2.2:8000/api';

  Future<List<dynamic>> getMatchesByTournamentId(int tournamentId) async {
    var response =
        await http.get(Uri.parse('$apiUrl/tournaments/$tournamentId/matches'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    }
    return [];
  }

  Future<bool> addMatch(
    int tournamentId,
    int homeTeamId,
    int awayTeamId,
    int venueId,
    String matchDate,
    int homeTeamScore,
    int awayTeamScore,
  ) async {
    var url = Uri.parse('$apiUrl/matches');
    var venueToSend = venueId != 0 ? venueId : null; // Check if venueId is 0

    var response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json'
      },
      body: json.encode(<String, dynamic>{
        'tournament_id': tournamentId,
        'home_team_id': homeTeamId,
        'away_team_id': awayTeamId,
        'venue_id': venueToSend, // Send null if venueId is 0
        'match_date': matchDate,
        'home_team_score': homeTeamScore,
        'away_team_score': awayTeamScore,
      }),
    );

    return response.statusCode == 201;
  }

  Future<bool> updateMatch(int matchId, int homeTeamScore, int awayTeamScore,
      String matchDate) async {
    var url = Uri.parse('$apiUrl/matches/$matchId');
    var response = await http.put(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json'
      },
      body: json.encode(<String, dynamic>{
        'home_team_score': homeTeamScore,
        'away_team_score': awayTeamScore,
        'match_date': matchDate,
      }),
    );
    return response.statusCode == 200;
  }

  Future<bool> deletePlayer(int matchId) async {
    var response = await http.delete(Uri.parse('$apiUrl/matches/$matchId'));
    return response.statusCode == 200;
  }

  Future<dynamic> addVenue(String name, String city) async {
    var url = Uri.parse('$apiUrl/venues');
    var response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode(<String, dynamic>{
        'name': name,
        'city': city,
      }),
    );

    if (response.statusCode == 201) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to create venue');
    }
  }

  Future<bool> deleteVenue(int venueId) async {
    var response = await http.delete(Uri.parse('$apiUrl/venues/$venueId'));
    return response.statusCode == 200;
  }
}
