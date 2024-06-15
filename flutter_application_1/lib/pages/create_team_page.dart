import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/http_service.dart';

class CreateTeamScreen extends StatefulWidget {
  @override
  _CreateTeamScreenState createState() => _CreateTeamScreenState();
}

class _CreateTeamScreenState extends State<CreateTeamScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _gameController = TextEditingController();
  final TextEditingController _regionController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _gameController.dispose();
    _regionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Team'),
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
                controller: _regionController,
                decoration: InputDecoration(labelText: 'region'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the region';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    var newTeam = await HttpService().addTeam(
                      _nameController.text,
                      _gameController.text,
                      _regionController.text,
                    );
                    if (newTeam != null) {
                      Navigator.of(context).pop(newTeam);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('Failed to create tournament'),
                      ));
                    }
                  }
                },
                child: Text('Create'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
