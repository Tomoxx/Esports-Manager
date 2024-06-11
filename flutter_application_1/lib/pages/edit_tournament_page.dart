import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/http_service.dart';

class EditTournamentScreen extends StatefulWidget {
  final Map<String, dynamic> tournament;

  EditTournamentScreen({required this.tournament});

  @override
  _EditTournamentScreenState createState() => _EditTournamentScreenState();
}

class _EditTournamentScreenState extends State<EditTournamentScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _gameController;
  late TextEditingController _typeController;
  late TextEditingController _startDateController;
  late TextEditingController _endDateController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.tournament['name']);
    _gameController = TextEditingController(text: widget.tournament['game']);
    _typeController = TextEditingController(text: widget.tournament['type']);
    _startDateController =
        TextEditingController(text: widget.tournament['start_date']);
    _endDateController =
        TextEditingController(text: widget.tournament['end_date']);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _gameController.dispose();
    _typeController.dispose();
    _startDateController.dispose();
    _endDateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Tournament'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _gameController,
                decoration: InputDecoration(labelText: 'Game'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the game';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _typeController,
                decoration: InputDecoration(labelText: 'Type'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the type';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _startDateController,
                decoration: InputDecoration(labelText: 'Start Date'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the start date';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _endDateController,
                decoration: InputDecoration(labelText: 'End Date'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the end date';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    var updatedTournament =
                        await HttpService().updateTournament(
                      widget.tournament['id'],
                      _nameController.text,
                      _gameController.text,
                      _typeController.text,
                      _startDateController.text,
                      _endDateController.text,
                    );
                    if (updatedTournament != null) {
                      Navigator.of(context).pop(updatedTournament);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('Failed to update tournament'),
                      ));
                    }
                  }
                },
                child: Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
