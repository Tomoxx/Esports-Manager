import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/http_service_2.dart';
import 'package:intl/intl.dart';

class EditMatchScreen extends StatefulWidget {
  final int matchId;
  final int homeTeamScore;
  final int awayTeamScore;
  final String matchDate; // Add match date parameter

  EditMatchScreen({
    required this.matchId,
    required this.homeTeamScore,
    required this.awayTeamScore,
    required this.matchDate, // Add match date parameter
  });

  @override
  _EditMatchScreenState createState() => _EditMatchScreenState();
}

class _EditMatchScreenState extends State<EditMatchScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _homeTeamScoreController;
  late TextEditingController _awayTeamScoreController;
  late TextEditingController _dateController;
  late TextEditingController _timeController;
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();

  @override
  void initState() {
    super.initState();
    _homeTeamScoreController =
        TextEditingController(text: widget.homeTeamScore.toString());
    _awayTeamScoreController =
        TextEditingController(text: widget.awayTeamScore.toString());
    DateTime initialDateTime = DateTime.parse(widget.matchDate);
    _selectedDate = initialDateTime;
    _selectedTime = TimeOfDay.fromDateTime(initialDateTime);
    _dateController = TextEditingController(
        text: DateFormat('yyyy-MM-dd').format(initialDateTime));
    _timeController = TextEditingController(
        text: DateFormat('HH:mm').format(initialDateTime));
  }

  void _updateMatch() async {
    if (_formKey.currentState!.validate()) {
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

      bool success = await HttpService2().updateMatch(
        widget.matchId,
        homeTeamScore,
        awayTeamScore,
        formattedMatchDate, // Send the formatted date string
      );

      if (success) {
        Navigator.pop(context, true);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Match updated successfully')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to update match')),
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
        title: Text('Edit Match'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
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
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: _updateMatch,
                child: Text('Update Match'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
