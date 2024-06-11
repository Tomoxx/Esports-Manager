import 'dart:collection';
import 'dart:convert';
import 'package:http/http.dart' as http;

class HttpService {
  final String apiUrl = 'http://10.0.2.2:8000/api';

  Future<List<dynamic>> listTournaments() async {
    return listData('tournaments');
  }

  Future<List<dynamic>> listData(String collection) async {
    var response = await http.get(Uri.parse(apiUrl + '/' + collection));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    }
    print(response.statusCode);
    print(response);
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

  Future<bool> deleteTeam(int teamId) async {
    var response =
        await http.delete(Uri.parse(apiUrl + '/teams/' + teamId.toString()));
    return response.statusCode == 200;
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

  Future<List<dynamic>> getTeamsByTournamentId(int tournamentId) async {
    var response =
        await http.get(Uri.parse('$apiUrl/tournaments/$tournamentId/teams'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    }
    print(response.statusCode);
    print(response);
    return [];
  }

  Future<List<dynamic>> getPlayersByTeamId(int teamId) async {
    var response = await http.get(Uri.parse('$apiUrl/teams/$teamId/players'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    }
    print(response.statusCode);
    print(response);
    return [];
  }
}
