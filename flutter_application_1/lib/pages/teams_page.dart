import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/create_team_page.dart';
import 'package:flutter_application_1/pages/team_details_page.dart';
import 'package:flutter_application_1/services/http_service.dart';

class TeamsScreen extends StatefulWidget {
  @override
  _TeamsScreenState createState() => _TeamsScreenState();
}

class _TeamsScreenState extends State<TeamsScreen> {
  late Future<List<dynamic>> _teams;

  @override
  void initState() {
    super.initState();
    _teams = HttpService().listData('teams');
  }

  void _loadTeams() {
    setState(() {
      _teams = HttpService().listData('teams');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Teams'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () async {
              var newTournament = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CreateTeamScreen(),
                ),
              );

              if (newTournament != null) {
                _loadTeams();
              }
            },
          ),
        ],
      ),
      body: FutureBuilder<List<dynamic>>(
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
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    elevation: 5,
                    child: ListTile(
                      title: Text(
                        team['name'],
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text('Game: ${team['game']}'),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TeamDetailsScreen(team: team),
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
