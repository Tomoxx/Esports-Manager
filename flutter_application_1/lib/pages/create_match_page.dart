import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/http_service.dart';
import 'package:flutter_application_1/services/http_service_2.dart';
import 'package:intl/intl.dart';

class CreateMatchScreen extends StatefulWidget {
  final int tournamentId;

  CreateMatchScreen({required this.tournamentId});

  @override
  _CreateMatchScreenState createState() => _CreateMatchScreenState();
}

class _CreateMatchScreenState extends State<CreateMatchScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _venueController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _homeTeamScoreController =
      TextEditingController();
  final TextEditingController _awayTeamScoreController =
      TextEditingController();

  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();

  late Future<List<dynamic>> _teams;
  late Future<List<dynamic>> _venues; // Future for fetching venues
  Map<String, dynamic>? _selectedHomeTeam;
  Map<String, dynamic>? _selectedAwayTeam;
  Map<String, dynamic>? _selectedVenue; // Selected venue

  @override
  void initState() {
    super.initState();
    _teams = _fetchTeamsByTournamentId(widget.tournamentId);
    _venues = _fetchVenues();
  }

  Future<List<dynamic>> _fetchTeamsByTournamentId(int tournamentId) async {
    try {
      var teams = await HttpService().getTeamsByTournamentId(tournamentId);
      return teams;
    } catch (e) {
      print('Failed to fetch teams: $e');
      return []; // or handle error appropriately
    }
  }

  Future<List<dynamic>> _fetchVenues() async {
    try {
      var venues = await HttpService()
          .listData("venues"); // Adjust this based on your API
      return venues;
    } catch (e) {
      print('Failed to fetch venues: $e');
      return []; // or handle error appropriately
    }
  }

  void _createMatch() async {
    if (_formKey.currentState!.validate()) {
      final homeTeamId = _selectedHomeTeam!['id'];
      final awayTeamId = _selectedAwayTeam!['id'];
      final venueId = _selectedVenue != null
          ? _selectedVenue!['id']
          : 0; // Use selected venue ID if available
      final homeTeamScore = int.parse(_homeTeamScoreController.text);
      final awayTeamScore = int.parse(_awayTeamScoreController.text);

      final matchDate = DateTime(
        _selectedDate.year,
        _selectedDate.month,
        _selectedDate.day,
        _selectedTime.hour,
        _selectedTime.minute,
      );

      String formattedMatchDate =
          DateFormat('yyyy-MM-dd HH:mm').format(matchDate);

      try {
        var newMatch = await HttpService2().addMatch(
          widget.tournamentId,
          homeTeamId,
          awayTeamId,
          venueId,
          formattedMatchDate, // Send the formatted date string
          homeTeamScore,
          awayTeamScore,
        );

        Navigator.pop(context, newMatch);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Match created successfully')),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to create match: $e')),
        );
      }
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );

    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
        _dateController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );

    if (pickedTime != null) {
      setState(() {
        _selectedTime = pickedTime;
        _timeController.text =
            pickedTime.format(context); // Format time for display
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Match'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: FutureBuilder<List<dynamic>>(
            future: _teams,
            builder: (context, teamsSnapshot) {
              if (teamsSnapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (teamsSnapshot.hasError) {
                return Center(
                    child:
                        Text('Failed to fetch teams: ${teamsSnapshot.error}'));
              } else if (!teamsSnapshot.hasData ||
                  teamsSnapshot.data!.isEmpty) {
                return Center(child: Text('No teams available.'));
              } else {
                List<dynamic> teams = teamsSnapshot.data!;
                return FutureBuilder<List<dynamic>>(
                  future: _venues,
                  builder: (context, venuesSnapshot) {
                    if (venuesSnapshot.connectionState ==
                        ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (venuesSnapshot.hasError) {
                      return Center(
                          child: Text(
                              'Failed to fetch venues: ${venuesSnapshot.error}'));
                    } else if (!venuesSnapshot.hasData ||
                        venuesSnapshot.data!.isEmpty) {
                      return Center(child: Text('No venues available.'));
                    } else {
                      List<dynamic> venues = venuesSnapshot.data!;
                      return ListView(
                        children: [
                          DropdownButtonFormField<Map<String, dynamic>>(
                            value: _selectedHomeTeam,
                            onChanged: (value) {
                              setState(() {
                                _selectedHomeTeam = value;
                              });
                            },
                            decoration: InputDecoration(
                              labelText: 'Select Home Team',
                            ),
                            items: teams.map((team) {
                              return DropdownMenuItem<Map<String, dynamic>>(
                                value: team,
                                child: Text(team['name']),
                              );
                            }).toList(),
                            validator: (value) {
                              if (value == null) {
                                return 'Please select the home team';
                              }
                              return null;
                            },
                          ),
                          DropdownButtonFormField<Map<String, dynamic>>(
                            value: _selectedAwayTeam,
                            onChanged: (value) {
                              setState(() {
                                _selectedAwayTeam = value;
                              });
                            },
                            decoration: InputDecoration(
                              labelText: 'Select Away Team',
                            ),
                            items: teams.map((team) {
                              return DropdownMenuItem<Map<String, dynamic>>(
                                value: team,
                                child: Text(team['name']),
                              );
                            }).toList(),
                            validator: (value) {
                              if (value == null) {
                                return 'Please select the away team';
                              } else if (value == _selectedHomeTeam) {
                                return 'Home and away teams must be different';
                              }
                              return null;
                            },
                          ),
                          DropdownButtonFormField<Map<String, dynamic>>(
                            value: _selectedVenue,
                            onChanged: (value) {
                              setState(() {
                                _selectedVenue = value;
                              });
                            },
                            decoration: InputDecoration(
                              labelText: 'Select Venue (optional)',
                            ),
                            items: venues.map((venue) {
                              return DropdownMenuItem<Map<String, dynamic>>(
                                value: venue,
                                child: Text(venue['name']),
                              );
                            }).toList(),
                          ),
                          TextFormField(
                            controller: _dateController,
                            decoration: InputDecoration(
                              labelText: 'Match Date',
                              suffixIcon: IconButton(
                                icon: Icon(Icons.calendar_today),
                                onPressed: () => _selectDate(context),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter the match date';
                              }
                              return null;
                            },
                            readOnly: true,
                          ),
                          TextFormField(
                            controller: _timeController,
                            decoration: InputDecoration(
                              labelText: 'Match Time',
                              suffixIcon: IconButton(
                                icon: Icon(Icons.access_time),
                                onPressed: () => _selectTime(context),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter the match time';
                              }
                              return null;
                            },
                            readOnly: true,
                          ),
                          TextFormField(
                            controller: _homeTeamScoreController,
                            decoration: InputDecoration(
                              labelText: 'Home Team Score',
                            ),
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter the home team score';
                              }
                              return null;
                            },
                          ),
                          TextFormField(
                            controller: _awayTeamScoreController,
                            decoration: InputDecoration(
                              labelText: 'Away Team Score',
                            ),
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter the away team score';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 20.0),
                          ElevatedButton(
                            onPressed: _createMatch,
                            child: Text('Create Match'),
                          ),
                        ],
                      );
                    }
                  },
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
