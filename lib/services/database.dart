import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DatabaseService {

  final String uid;

  DatabaseService({ this.uid });

  // collection reference
  final CollectionReference brewCollection = Firestore.instance.collection('brews');

  Future updateUserData({ @required String sugars, @required int strength, @required String name}) async {
    try {
      return await brewCollection.document(uid).setData({
        'sugars': sugars,
        'name': name,
        'strength': strength
      });
    } catch(e) {
      print(e.toString());
      return null;
    }
  }

  // Get brews Stream
  Stream<QuerySnapshot> get brews {
    return brewCollection.snapshots();
  }
}