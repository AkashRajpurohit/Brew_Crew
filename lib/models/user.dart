import 'package:flutter/material.dart';

class User {

  final String uid;
  final String email;
  final bool isEmailVerified;

  User({ @required this.uid, @required this.email, @required this.isEmailVerified });

}

class UserData {

  final String uid;
  final String name;
  final String sugars;
  final int strength;
  
  UserData({ @required this.uid, @required this.strength, @required this.sugars, @required this.name });
  
}