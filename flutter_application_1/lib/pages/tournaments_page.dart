import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/create_tournament_page.dart';
import 'package:flutter_application_1/pages/tournament_details_page.dart';
import 'package:flutter_application_1/services/http_service.dart';

class TournamentsScreen extends StatefulWidget {
  @override
  _TournamentsScreenState createState() => _TournamentsScreenState();
}

class _TournamentsScreenState extends State<TournamentsScreen> {
  late Future<List<dynamic>> _tournaments;

  @override
  void initState() {
    super.initState();
    _tournaments = HttpService().listData('tournaments');
  }

  void _loadTournaments() {
    setState(() {
      _tournaments = HttpService().listData('tournaments');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tournaments'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () async {
              var newTournament = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CreateTournamentScreen(),
                ),
              );

              if (newTournament != null) {
                _loadTournaments();
              }
            },
          ),
        ],
      ),
      body: FutureBuilder<List<dynamic>>(
        future: _tournaments,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No tournaments found.'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                var tournament = snapshot.data![index];
                return ListTile(
                  title: Text(tournament['name']),
                  subtitle: Text(tournament['game']),
                  trailing: Text(
                      '${tournament['start_date']} - ${tournament['end_date']}'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TournamentDetailsScreen(
                                tournament: tournament,
                              )),
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
