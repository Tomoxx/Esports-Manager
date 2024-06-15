import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/http_service.dart';

class AddTeamPage extends StatefulWidget {
  final int tournamentId;
  final String game;

  AddTeamPage({required this.tournamentId, required this.game});

  @override
  _AddTeamPageState createState() => _AddTeamPageState();
}

class _AddTeamPageState extends State<AddTeamPage> {
  late Future<List<dynamic>> _teams;
  final TextEditingController _placementController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _teams = HttpService().listTeamsPerGame(widget.game);
  }

  @override
  void dispose() {
    _placementController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Team to Tournament'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _placementController,
              decoration: InputDecoration(
                labelText: 'Placement (Optional)',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
          ),
          Expanded(
            child: FutureBuilder<List<dynamic>>(
              future: _teams,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('No teams available.'));
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      var team = snapshot.data![index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 8.0,
                        ),
                        child: Card(
                          elevation: 3,
                          child: ListTile(
                            title: Text(team['name']),
                            subtitle: Text('Region: ${team['region']}'),
                            trailing: IconButton(
                              icon: Icon(Icons.add),
                              onPressed: () async {
                                var addedTeam =
                                    await HttpService().addTeamToTournament({
                                  'tournament_id': widget.tournamentId,
                                  'team_id': team['id'],
                                  'placement': _placementController.text,
                                });
                                if (addedTeam != null) {
                                  Navigator.pop(context, addedTeam);
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: Text('Team added successfully'),
                                  ));
                                } else {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: Text('Failed to add team'),
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
        ],
      ),
    );
  }
}
