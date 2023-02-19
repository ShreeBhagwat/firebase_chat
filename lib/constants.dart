import 'package:flutter/material.dart';

const TextStyle kTitleTextStyle = TextStyle(
  fontSize: 26.0,
  fontWeight: FontWeight.bold,
);

const TextStyle kSubtitleTextStyle = TextStyle(
    fontSize: 16.0, fontWeight: FontWeight.normal, color: Colors.grey);

const TextStyle kBodyTextStyle = TextStyle(
  fontSize: 16.0,
);

const TextStyle kButtonTextStyle = TextStyle(
  fontSize: 18.0,
  fontWeight: FontWeight.bold,
);

const OutlineInputBorder kTextFieldBorder = OutlineInputBorder(
  borderRadius: BorderRadius.all(Radius.circular(10.0)),
  borderSide: BorderSide(color: Colors.grey, width: 1),
);

const OutlineInputBorder kTextFieldFocusedBorder = OutlineInputBorder(
  borderRadius: BorderRadius.all(Radius.circular(10.0)),
  borderSide: BorderSide(color: Colors.amber, width: 2),
);

const OutlineInputBorder kTextFieldErrorBorder = OutlineInputBorder(
  borderRadius: BorderRadius.all(Radius.circular(10.0)),
  borderSide: BorderSide(color: Colors.red, width: 2),
);
