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
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              elevation: 5,
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('ID: ${widget.team['id']}',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                    SizedBox(height: 10),
                    Text('Name: ${widget.team['name']}',
                        style: TextStyle(fontSize: 16)),
                    SizedBox(height: 10),
                    Text('Game: ${widget.team['game']}',
                        style: TextStyle(fontSize: 16)),
                    SizedBox(height: 10),
                    Text('Region: ${widget.team['region']}',
                        style: TextStyle(fontSize: 16)),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Text('Players:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
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
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            elevation: 5,
                            child: ListTile(
                              title: Text(player['name'],
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
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
                                      content:
                                          Text('Player deleted successfully'),
                                    ));
                                  } else {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      content: Text('Failed to delete player'),
                                    ));
                                  }
                                },
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
            SizedBox(height: 10),
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
              style: ElevatedButton.styleFrom(
                minimumSize:
                    Size.fromHeight(50), // Add this line to set a fixed height
              ),
            ),
          ],
        ),
      ),
    );
  }
}
