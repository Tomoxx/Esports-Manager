import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/edit_tournament_page.dart';
import 'package:flutter_application_1/services/http_service.dart';

class TournamentDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> tournament;

  TournamentDetailsScreen({required this.tournament});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tournament Details'),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () async {
              var updatedTournament = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      EditTournamentScreen(tournament: tournament),
                ),
              );

              if (updatedTournament != null) {
                // Update the tournament details screen with the new data
                tournament['name'] = updatedTournament['name'];
                tournament['game'] = updatedTournament['game'];
                tournament['type'] = updatedTournament['type'];
                tournament['start_date'] = updatedTournament['start_date'];
                tournament['end_date'] = updatedTournament['end_date'];
              }
            },
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () async {
              bool deleted =
                  await HttpService().deleteTournament(tournament['id']);
              if (deleted) {
                Navigator.of(context)
                    .pop(); // Go back to the previous screen after deleting
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text('Tournament deleted successfully'),
                ));
              } else {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text('Failed to delete tournament'),
                ));
              }
            },
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('ID: ${tournament['id']}'),
          Text('Name: ${tournament['name']}'),
          Text('Game: ${tournament['game']}'),
          Text('Type: ${tournament['type']}'),
          Text('Start Date: ${tournament['start_date']}'),
          Text('End Date: ${tournament['end_date']}'),
          SizedBox(height: 20),
          Text('Teams:', style: TextStyle(fontWeight: FontWeight.bold)),
          Expanded(
            child: FutureBuilder<List<dynamic>>(
              future: HttpService().getTeamsByTournamentId(tournament['id']),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('No teams found.'));
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      var team = snapshot.data![index]['team'];
                      return ListTile(
                        title: Text(team['name']),
                        subtitle: Text('Region: ${team['region']}'),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
