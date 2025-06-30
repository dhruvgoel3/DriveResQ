import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    primarySwatch: Colors.deepPurple,
    fontFamily: 'Roboto',
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
      elevation: 0,
      backgroundColor: Colors.deepPurple,
      foregroundColor: Colors.white,
    ),
  );
}
