import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:testmoviesapp/home.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primaryColor: Colors.white
    ),
    home: Home(),
  ));

  SystemChrome.setEnabledSystemUIOverlays([]);
}
