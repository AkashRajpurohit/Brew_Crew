import 'package:brew_crew/shared/constants.dart';
import 'package:flutter/material.dart';

class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> sugars = ['0', '1', '2', '3', '4', '5'];

  String _currentName;
  String _currentSugars;
  int _currentStrength;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          Text(
            "Update your brew settings",
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20.0),
          TextFormField(
            decoration: textInputDecoration.copyWith(
                labelText: 'Enter Your Name',
                prefixIcon: Icon(Icons.person_outline)),
            validator: (val) => val.isEmpty ? 'Please enter a name' : null,
            onChanged: (val) => setState(() => _currentName = val),
          ),
          SizedBox(height: 20.0),
          DropdownButtonFormField(
            decoration: textInputDecoration.copyWith(
              prefixIcon: Icon(Icons.opacity)
            ),
            value: _currentSugars ?? '0',
            items: sugars.map((sugar) {
              return DropdownMenuItem(
                value: sugar,
                child: Text('$sugar sugars'),
              );
            }).toList(),
            onChanged: (val) => setState(() => _currentSugars = val),
          ),
          SizedBox(height: 20.0),
          Slider(
              value: (_currentStrength ?? 100).toDouble(),
              min: 100,
              divisions: 8,
              max: 900,
              activeColor: Colors.brown[_currentStrength ?? 100],
              inactiveColor: Colors.brown[_currentStrength ?? 100],
              label: (_currentStrength ?? 100) < 400
                  ? 'Low Strength'
                  : (_currentStrength ?? 100) >= 400 &&
                          (_currentStrength ?? 100) < 700
                      ? 'Medium Strength'
                      : 'High Strength',
              onChanged: (val) =>
                  setState(() => _currentStrength = val.round())),
          SizedBox(height: 20.0),
          RaisedButton(
            color: Colors.pink[400],
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
              child: Text(
                'Update',
                style: TextStyle(color: Colors.white, fontSize: 16.0),
              ),
            ),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
