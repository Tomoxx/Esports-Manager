import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/http_service.dart';

class EditTeamScreen extends StatefulWidget {
  final Map<String, dynamic> team;

  EditTeamScreen({required this.team});

  @override
  _EditTeamScreenState createState() => _EditTeamScreenState();
}

class _EditTeamScreenState extends State<EditTeamScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _name;
  late String _game;
  late String _region;

  @override
  void initState() {
    super.initState();
    _name = widget.team['name'];
    _game = widget.team['game'];
    _region = widget.team['region'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Team'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: _name,
                decoration: InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
                onSaved: (value) {
                  _name = value!;
                },
              ),
              TextFormField(
                initialValue: _game,
                decoration: InputDecoration(labelText: 'Game'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a game';
                  }
                  return null;
                },
                onSaved: (value) {
                  _game = value!;
                },
              ),
              TextFormField(
                initialValue: _region,
                decoration: InputDecoration(labelText: 'Region'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a region';
                  }
                  return null;
                },
                onSaved: (value) {
                  _region = value!;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();

                    var updatedTeam = await HttpService().updateTeam(
                      widget.team['id'],
                      _name,
                      _game,
                      _region,
                    );

                    Navigator.of(context).pop(updatedTeam);
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
