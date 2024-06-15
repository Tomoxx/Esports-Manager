import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/create_player_page.dart';
import 'package:flutter_application_1/pages/edit_team_page.dart';
import 'package:flutter_application_1/services/http_service.dart';

class TeamDetailsScreen extends StatefulWidget {
  final Map<String, dynamic> team;

  TeamDetailsScreen({required this.team});

  @override
  _TeamDetailsScreenState createState() => _TeamDetailsScreenState();
}

class _TeamDetailsScreenState extends State<TeamDetailsScreen> {
  late Future<List<dynamic>> _players;

  @override
  void initState() {
    super.initState();
    _players = HttpService().getPlayersByTeamId(widget.team['id']);
  }

  void _refreshPlayers() {
    setState(() {
      _players = HttpService().getPlayersByTeamId(widget.team['id']);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Team Details'),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () async {
              var updatedTeam = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditTeamScreen(team: widget.team),
                ),
              );

              if (updatedTeam != null) {
                setState(() {
                  widget.team['name'] = updatedTeam['name'];
                });
              }
            },
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () async {
              bool deleted = await HttpService().deleteTeam(widget.team['id']);
              if (deleted) {
                Navigator.of(context)
                    .pop(); // Go back to the previous screen after deleting
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text('Team deleted successfully'),
                ));
              } else {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text('Failed to delete team'),
                ));
              }
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('ID: ${widget.team['id']}'),
            Text('Name: ${widget.team['name']}'),
            SizedBox(height: 20),
            Text('Players:', style: TextStyle(fontWeight: FontWeight.bold)),
            Expanded(
              child: FutureBuilder<List<dynamic>>(
                future: _players,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text('No players found.'));
                  } else {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        var player = snapshot.data![index];
                        return ListTile(
                          title: Text(player['name']),
                          trailing: IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () async {
                              bool deleted = await HttpService()
                                  .deletePlayer(player['id']);
                              if (deleted) {
                                setState(() {
                                  snapshot.data!.removeAt(index);
                                });
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Text('Player deleted successfully'),
                                ));
                              } else {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Text('Failed to delete player'),
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
                var newPlayer = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        AddPlayerScreen(teamId: widget.team['id']),
                  ),
                );

                if (newPlayer != null) {
                  _refreshPlayers();
                }
              },
              child: Text('Add Player'),
            ),
          ],
        ),
      ),
    );
  }
}
