import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const Color primary = Color(0xFF6773FC);

Color  bgColor({isDark = false}) =>  isDark ? Color(0XFF0A0A0A):Color(0XFFF6F7F9);

const Color white = Colors.white;

const Color black = Colors.black;

const Color textColor = Color(0xff433D57);

const Color darkGrey = Color(0xff5A5A5A);

const Color grey = Color(0xff909090);

const Color lightGrey = Color(0xff5C5C5C);

themeData(context) => ThemeData(
      textTheme: GoogleFonts.montserratTextTheme(Theme.of(context).textTheme),
      primarySwatch: Colors.blue,
      primaryColor: primary,
      brightness: Brightness.light,
      backgroundColor: bgColor(),
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );

darkThemeData(context) => ThemeData.dark().copyWith(
      textTheme: GoogleFonts.montserratTextTheme(Theme.of(context).textTheme),
      primaryColor: primary,
      backgroundColor: bgColor(isDark: true),
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );
