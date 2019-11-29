import 'package:brew_crew/models/user.dart';
import 'package:brew_crew/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Create user object based on firebase user
  User _userFromFirbaseUser(FirebaseUser user) {
    return user != null 
      ? User(
        uid: user.uid, 
        email: user.email, 
        isEmailVerified: user.isEmailVerified
      ) 
      : null;
  }

  // Auth Change user stream
  Stream<User> get user {
    return _auth.onAuthStateChanged.map(_userFromFirbaseUser);
  }

  // Sign in anon
  Future signInAnon() async {
    try {
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      return _userFromFirbaseUser(user);
    } catch(e) {
      print(e.toString());
      return null;
    }
  }

  // Sign in with email & password
  Future signInWithEmailAndPassword({ @required String email, @required String password}) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);

      FirebaseUser user = result.user;

      return _userFromFirbaseUser(user);
    } catch(e) {
      print(e.toString());
      return null;
    }
  }

  // Register with email & password
  Future registerWithEmailAndPassword({ @required String email, @required String password}) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);

      FirebaseUser user = result.user;

      // create a new document for the user with the user id
      await DatabaseService(uid: user.uid).updateUserData(
        name: 'New Crew Member',
        strength: 100,
        sugars: '0'
      );

      return _userFromFirbaseUser(user);
    } catch(e) {
      print(e.toString());
      return null;
    }
  }

  // Sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch(e) {
      print(e.toString());
      return null;
    }
  }

}