import 'dart:collection';
import 'dart:convert';
import 'package:http/http.dart' as http;

class HttpService {
  final String apiUrl = 'http://10.0.2.2:8000/api';

  Future<List<dynamic>> listData(String collection) async {
    var response = await http.get(Uri.parse(apiUrl + '/' + collection));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    }
    return [];
  }

  Future<List<dynamic>> listTeamsPerGame(String game) async {
    var response = await http.get(Uri.parse(apiUrl + '/' + 'teams'));

    if (response.statusCode == 200) {
      List<dynamic> teams = json.decode(response.body);
      teams = teams.where((team) => team['game'] == game).toList();
      return teams;
    }
    return [];
  }

  Future<LinkedHashMap<String, dynamic>> addTournament(String name, String game,
      String type, String startDate, String endDate) async {
    var url = Uri.parse('$apiUrl/tournaments');
    var response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json'
      },
      body: json.encode(<String, dynamic>{
        'name': name,
        'game': game,
        'type': type,
        'start_date': startDate,
        'end_date': endDate,
      }),
    );
    return json.decode(response.body);
  }

  Future<bool> deleteTournament(int tournamentId) async {
    var response = await http
        .delete(Uri.parse(apiUrl + '/tournaments/' + tournamentId.toString()));
    return response.statusCode == 200;
  }

  Future<List<dynamic>> getTeamsByTournamentId(int tournamentId) async {
    var response =
        await http.get(Uri.parse('$apiUrl/tournaments/$tournamentId/teams'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    }
    return [];
  }

  Future<LinkedHashMap<String, dynamic>> updateTournament(int id, String name,
      String game, String type, String startDate, String endDate) async {
    var url = Uri.parse('$apiUrl/tournaments/$id');
    var response = await http.put(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
      },
      body: json.encode(<String, dynamic>{
        'name': name,
        'game': game,
        'type': type,
        'start_date': startDate,
        'end_date': endDate,
      }),
    );
    return json.decode(response.body);
  }

  Future<Map<String, dynamic>?> addTeamToTournament(
      Map<String, dynamic> data) async {
    final response = await http.post(
      Uri.parse('$apiUrl/tournament_teams'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(data),
    );
    if (response.statusCode == 201) {
      return json.decode(response.body);
    } else {
      return null;
    }
  }

  Future<bool> deleteTeamFromTournament(int tournament_teamId) async {
    var response = await http
        .delete(Uri.parse('$apiUrl/tournament_teams/$tournament_teamId'));
    return response.statusCode == 200;
  }

  Future<List<dynamic>> getPlayersByTeamId(int teamId) async {
    var response = await http.get(Uri.parse('$apiUrl/teams/$teamId/players'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    }
    return [];
  }

  Future<LinkedHashMap<String, dynamic>> addTeam(
      String name, String game, String region) async {
    var url = Uri.parse('$apiUrl/teams');
    var response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json'
      },
      body: json.encode(<String, dynamic>{
        'name': name,
        'game': game,
        'region': region,
      }),
    );
    return json.decode(response.body);
  }

  Future<LinkedHashMap<String, dynamic>> updateTeam(
      int id, String name, String game, String region) async {
    var url = Uri.parse('$apiUrl/teams/$id');
    var response = await http.put(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
      },
      body: json.encode(
          <String, dynamic>{'name': name, 'game': game, 'region': region}),
    );
    return json.decode(response.body);
  }

  Future<bool> deleteTeam(int teamId) async {
    var response = await http.delete(Uri.parse('$apiUrl/teams/$teamId'));
    return response.statusCode == 200;
  }

  Future<Map<String, dynamic>> addPlayerToTeam(
      int teamId, String playerName) async {
    var response = await http.post(
      Uri.parse('$apiUrl/players'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'name': playerName,
        'team_id': teamId,
      }),
    );

    if (response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to add player');
    }
  }

  Future<bool> deletePlayer(int playerId) async {
    var response = await http.delete(Uri.parse('$apiUrl/players/$playerId'));
    return response.statusCode == 200;
  }
}
