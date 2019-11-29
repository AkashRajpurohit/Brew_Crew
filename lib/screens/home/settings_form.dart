import 'package:brew_crew/models/user.dart';
import 'package:brew_crew/services/database.dart';
import 'package:brew_crew/shared/constants.dart';
import 'package:brew_crew/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    final user = Provider.of<User>(context);

    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData userData = snapshot.data;

            return Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Text(
                    "Update your brew settings",
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    initialValue: userData.name,
                    decoration: textInputDecoration.copyWith(
                        labelText: 'Your Name',
                        prefixIcon: Icon(Icons.person_outline)),
                    validator: (val) =>
                        val.isEmpty ? 'Please enter a name' : null,
                    onChanged: (val) => setState(() => _currentName = val),
                  ),
                  SizedBox(height: 20.0),
                  DropdownButtonFormField(
                    decoration: textInputDecoration.copyWith(
                        prefixIcon: Icon(Icons.opacity)),
                    value: _currentSugars ?? userData.sugars,
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
                      value: (_currentStrength ?? userData.strength).toDouble(),
                      min: 100,
                      divisions: 8,
                      max: 900,
                      activeColor:
                          Colors.brown[_currentStrength ?? userData.strength],
                      inactiveColor:
                          Colors.brown[_currentStrength ?? userData.strength],
                      label: (_currentStrength ?? userData.strength) < 400
                          ? 'Low Strength'
                          : (_currentStrength ?? userData.strength) >= 400 &&
                                  (_currentStrength ?? userData.strength) < 700
                              ? 'Medium Strength'
                              : 'High Strength',
                      onChanged: (val) =>
                          setState(() => _currentStrength = val.round())),
                  SizedBox(height: 20.0),
                  RaisedButton(
                    color: Colors.pink[400],
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                      child: Text(
                        'Update',
                        style: TextStyle(color: Colors.white, fontSize: 16.0),
                      ),
                    ),
                    onPressed: () async {
                      if(_formKey.currentState.validate()) {
                        await DatabaseService(uid: user.uid).updateUserData(
                          name: _currentName ?? userData.name,
                          sugars: _currentSugars ?? userData.sugars,
                          strength: _currentStrength ?? userData.strength
                        );

                        Navigator.pop(context);
                      }
                    },
                  ),
                ],
              ),
            );
          } else {
            return Loading();
          }
        });
  }
}
