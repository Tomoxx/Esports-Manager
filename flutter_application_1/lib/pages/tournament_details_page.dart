import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/add_team_page.dart';
import 'package:flutter_application_1/pages/edit_tournament_page.dart';
import 'package:flutter_application_1/pages/team_details_page.dart';
import 'package:flutter_application_1/services/http_service.dart';

class TournamentDetailsScreen extends StatefulWidget {
  final Map<String, dynamic> tournament;

  TournamentDetailsScreen({required this.tournament});

  @override
  _TournamentDetailsScreenState createState() =>
      _TournamentDetailsScreenState();
}

class _TournamentDetailsScreenState extends State<TournamentDetailsScreen> {
  late Future<List<dynamic>> _teams;

  @override
  void initState() {
    super.initState();
    _teams = HttpService().getTeamsByTournamentId(widget.tournament['id']);
  }

  void _refreshTeams() {
    setState(() {
      _teams = HttpService().getTeamsByTournamentId(widget.tournament['id']);
    });
  }

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
                      EditTournamentScreen(tournament: widget.tournament),
                ),
              );

              if (updatedTournament != null) {
                setState(() {
                  widget.tournament['name'] = updatedTournament['name'];
                  widget.tournament['game'] = updatedTournament['game'];
                  widget.tournament['type'] = updatedTournament['type'];
                  widget.tournament['start_date'] =
                      updatedTournament['start_date'];
                  widget.tournament['end_date'] = updatedTournament['end_date'];
                });
              }
            },
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () async {
              bool deleted =
                  await HttpService().deleteTournament(widget.tournament['id']);
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
          Text('ID: ${widget.tournament['id']}'),
          Text('Name: ${widget.tournament['name']}'),
          Text('Game: ${widget.tournament['game']}'),
          Text('Type: ${widget.tournament['type']}'),
          Text('Start Date: ${widget.tournament['start_date']}'),
          Text('End Date: ${widget.tournament['end_date']}'),
          SizedBox(height: 20),
          Text('Teams:', style: TextStyle(fontWeight: FontWeight.bold)),
          Expanded(
            child: FutureBuilder<List<dynamic>>(
              future: _teams,
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
                      var team = snapshot.data![index];
                      return ListTile(
                        title: Text("${team['name']} - ${team['placement']}"),
                        subtitle: Text('Region: ${team['region']}'),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  TeamDetailsScreen(team: team),
                            ),
                          );
                        },
                        trailing: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () async {
                            bool deleted = await HttpService()
                                .deleteTeamFromTournament(
                                    team['tournament_team_id']);
                            if (deleted) {
                              setState(() {
                                snapshot.data!.removeAt(index);
                              });
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text('Team removed successfully'),
                              ));
                            } else {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text('Failed to remove team'),
                              ));
                            }
                          },
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              var newTeam = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      AddTeamPage(tournamentId: widget.tournament['id']),
                ),
              );

              if (newTeam != null) {
                _refreshTeams(); // Refresh the list of teams after adding a new team
              }
            },
            child: Text('Add Team'),
          ),
        ],
      ),
    );
  }
}
