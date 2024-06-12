import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/http_service.dart';

class AddPlayerScreen extends StatefulWidget {
  final int teamId;

  AddPlayerScreen({required this.teamId});

  @override
  _AddPlayerScreenState createState() => _AddPlayerScreenState();
}

class _AddPlayerScreenState extends State<AddPlayerScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _name;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Player'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
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
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();

                    var newPlayer = await HttpService().addPlayerToTeam(
                      widget.teamId,
                      _name,
                    );

                    Navigator.of(context).pop(newPlayer);
                  }
                },
                child: Text('Add Player'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
