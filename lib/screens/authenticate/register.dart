import 'package:brew_crew/services/auth.dart';
import 'package:brew_crew/shared/constants.dart';
import 'package:brew_crew/shared/loading.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {

  final Function toggleView;

  Register({ @required this.toggleView });

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text("Sign up to Brew Crew"),
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person_outline),
            textColor: Colors.white,
            label: Text(
              "Sign In",
              style: TextStyle(
                color: Colors.white
              ),
            ),
            onPressed: () {
              widget.toggleView();
            },
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: loading ? Loading() : Form(
          key: _formKey,
          child: Column(
            children: <Widget> [
              SizedBox(height: 20.0),
              TextFormField(
                decoration: textInputDecoration.copyWith(
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.mail)
                ),
                validator: (val) => val.isEmpty ? 'Enter an email' : null,
                onChanged: (val) {
                  setState(() => email = val);
                },
                cursorColor: Colors.brown[600],
              ),
              SizedBox(height: 20.0),
              TextFormField(
                decoration: textInputDecoration.copyWith(
                  labelText: 'Password',
                  prefixIcon: Icon(Icons.lock)
                ),
                validator: (val) => val.length < 6 ? 'Enter a password 6+ characters long' : null,
                obscureText: true,
                onChanged: (val) {
                  setState(() => password = val);
                },
                cursorColor: Colors.brown[600],
              ),
              SizedBox(height: 20.0),
              RaisedButton(
                onPressed: () async {
                  if(_formKey.currentState.validate()) {
                    setState(() => loading = true);
                    
                    dynamic result = await _auth.registerWithEmailAndPassword(email: email, password: password);

                    if(result == null) {
                      setState(() {
                        loading = false;
                        error = 'Please supply a valid email';
                      });
                    }
                  }
                },
                color: Colors.pink[400],
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                  child: Text(
                    'Register',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0
                    ),
                  ),
                ),
              ),
              SizedBox(height: 12.0),
              Text(
                error,
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic
                )
              )
            ]
          )
        )
      ),
    );
  }
}