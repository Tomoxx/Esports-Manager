import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/edit_team_page.dart';
import 'package:flutter_application_1/services/http_service.dart';

class TeamDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> team;

  TeamDetailsScreen({required this.team});

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
                  builder: (context) => EditTeamScreen(team: team),
                ),
              );

              if (updatedTeam != null) {
                // Update the team details screen with the new data
                team['name'] = updatedTeam['name'];
              }
            },
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () async {
              bool deleted = await HttpService().deleteTeam(team['id']);
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
            Text('ID: ${team['id']}'),
            Text('Name: ${team['name']}'),
            SizedBox(height: 20),
            Text('Players:', style: TextStyle(fontWeight: FontWeight.bold)),
            Expanded(
              child: FutureBuilder<List<dynamic>>(
                future: HttpService().getPlayersByTeamId(team['id']),
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
                          subtitle: Text('ID: ${player['id']}'),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
