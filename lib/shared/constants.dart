import 'package:flutter/material.dart';

InputDecoration textInputDecoration = InputDecoration(
  hasFloatingPlaceholder: true,
  errorStyle: TextStyle(
    fontSize: 14.0,
    fontStyle: FontStyle.italic,
    color: Colors.red
  ),
  alignLabelWithHint: true,
  errorBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.red[300],
      width: 2.0
    )
  ),
  focusedErrorBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.red[600],
      width: 2.0
    )
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.brown[600],
      width: 2.0
    )
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.brown[200],
      width: 2.0
    )
  )
);