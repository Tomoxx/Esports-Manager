import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter_application_1/services/http_service_2.dart';
import 'package:flutter_application_1/pages/edit_match_page.dart';
import 'package:flutter_application_1/pages/create_match_page.dart';

class TournamentCalendarScreen extends StatefulWidget {
  final int tournamentId;

  TournamentCalendarScreen({required this.tournamentId});

  @override
  _TournamentCalendarScreenState createState() =>
      _TournamentCalendarScreenState();
}

class _TournamentCalendarScreenState extends State<TournamentCalendarScreen> {
  DateTime _selectedDay = DateTime.now(); // Default selected date
  late Future<List<dynamic>> _matches;
  List<dynamic> _allMatches = []; // To store all matches
  List<dynamic> _filteredMatches =
      []; // List to hold matches for the selected date

  @override
  void initState() {
    super.initState();
    _fetchMatches();
  }

  // Function to fetch matches from the API
  void _fetchMatches() async {
    List<dynamic> matches =
        await HttpService2().getMatchesByTournamentId(widget.tournamentId);
    setState(() {
      _allMatches = matches;
      _filterMatchesByDate();
    });
  }

  // Function to filter matches by the selected date
  void _filterMatchesByDate() {
    setState(() {
      _filteredMatches = _allMatches.where((match) {
        DateTime matchDate = DateTime.parse(match['match_date']);
        return isSameDay(matchDate, _selectedDay);
      }).toList();
    });
  }

  // Function to refresh matches list after creating, editing, or deleting
  void _refreshMatches() {
    _fetchMatches();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tournament Matches'),
      ),
      body: Column(
        children: [
          _buildCalendarContent(),
          Expanded(
            child: _buildMatchesList(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  CreateMatchScreen(tournamentId: widget.tournamentId),
            ),
          );
          if (result != null && result == true) {
            _refreshMatches();
          }
        },
        child: Icon(Icons.add),
        tooltip: 'Create Match',
      ),
    );
  }

  Widget _buildCalendarContent() {
    return TableCalendar(
      focusedDay: _selectedDay,
      firstDay: DateTime.utc(2024, 1, 1),
      lastDay: DateTime.utc(2024, 12, 31),
      calendarFormat: CalendarFormat.month,
      availableCalendarFormats: const {
        CalendarFormat.month: 'Month',
      },
      selectedDayPredicate: (day) {
        return isSameDay(_selectedDay, day);
      },
      onDaySelected: (selectedDay, focusedDay) {
        setState(() {
          _selectedDay = selectedDay;
          _filterMatchesByDate();
        });
      },
    );
  }

  Widget _buildMatchesList() {
    if (_filteredMatches.isEmpty) {
      return Center(child: Text('No matches on this date.'));
    }

    return ListView.builder(
      itemCount: _filteredMatches.length,
      itemBuilder: (context, index) {
        var match = _filteredMatches[index];
        var venueName =
            match['venue'] != null ? match['venue']['name'] : 'Online';

        // Determine the winner
        String winner;
        if (match['home_team_score'] > match['away_team_score']) {
          winner = 'Winner: ${match['home_team']['name']}';
        } else if (match['home_team_score'] < match['away_team_score']) {
          winner = 'Winner: ${match['away_team']['name']}';
        } else {
          winner = 'Draw';
        }

        return ListTile(
          title: Text(
              '${match['home_team']['name']} vs ${match['away_team']['name']}'),
          subtitle: Text('Venue: $venueName - Date: ${match['match_date']}'),
          trailing: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('${match['home_team_score']} - ${match['away_team_score']}'),
              Text(winner, style: TextStyle(color: Colors.green)),
            ],
          ),
          onTap: () async {
            var result = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => EditMatchScreen(
                  matchId: match['id'],
                  homeTeamScore: match['home_team_score'],
                  awayTeamScore: match['away_team_score'],
                  matchDate: match['match_date'],
                ),
              ),
            );
            if (result != null && result == true) {
              _refreshMatches();
            }
          },
        );
      },
    );
  }
}
