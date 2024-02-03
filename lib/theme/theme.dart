import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  colorScheme: const ColorScheme.light(
    background: Colors.white,
  ),
  textTheme: GoogleFonts.dmSansTextTheme().copyWith(
    bodyLarge: TextStyle(color: Colors.black),
    bodySmall: TextStyle(color: Colors.black),
  ),
);
ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  colorScheme: const ColorScheme.dark(
    background: Color.fromARGB(21, 224, 224, 224),
  ),
  textTheme: GoogleFonts.dmSansTextTheme().copyWith(
    bodyLarge: TextStyle(color: Colors.white),
    bodySmall: TextStyle(color: Colors.white),
  ),
);
