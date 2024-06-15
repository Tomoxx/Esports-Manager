import 'package:flutter/material.dart';
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
  final TextEditingController _homeTeamController = TextEditingController();
  final TextEditingController _awayTeamController = TextEditingController();
  final TextEditingController _venueController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _homeTeamScoreController =
      TextEditingController();
  final TextEditingController _awayTeamScoreController =
      TextEditingController();

  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();

  void _createMatch() async {
    if (_formKey.currentState!.validate()) {
      final homeTeamId = int.parse(_homeTeamController.text);
      final awayTeamId = int.parse(_awayTeamController.text);
      final venueId = _venueController.text.isNotEmpty
          ? int.parse(_venueController.text)
          : 0;
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
          child: ListView(
            children: [
              TextFormField(
                controller: _homeTeamController,
                decoration: InputDecoration(labelText: 'Home Team ID'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the home team ID';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _awayTeamController,
                decoration: InputDecoration(labelText: 'Away Team ID'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the away team ID';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _venueController,
                decoration: InputDecoration(labelText: 'Venue ID (optional)'),
                keyboardType: TextInputType.number,
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
                decoration: InputDecoration(labelText: 'Home Team Score'),
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
                decoration: InputDecoration(labelText: 'Away Team Score'),
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
          ),
        ),
      ),
    );
  }
}
