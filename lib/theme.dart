import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Rk0ccMaterialColour extends MaterialColor {
  static const int _primaryHex = 0xff33ff33;

  const Rk0ccMaterialColour()
      : super(_primaryHex, const <int, Color>{
          50: Color(0xffedffed),
          100: Color(0xffc9ffc9),
          200: Color(0xff83ff83),
          300: Color(_primaryHex),
          400: Color(0xff00e400),
          500: Color(0xff00c100),
          600: Color(0xff008c00),
          700: Color(0xff006900),
          800: Color(0xff004600),
          900: Color(0xff002300)
        });
}

final ThemeData rk0ccLightTheme = ThemeData(
    primaryColor: const Rk0ccMaterialColour(),
    disabledColor: const Rk0ccMaterialColour()[100],
    drawerTheme:
        DrawerThemeData(backgroundColor: const Rk0ccMaterialColour()[50]),
    appBarTheme: AppBarTheme(
        backgroundColor: const Rk0ccMaterialColour(),
        foregroundColor: const Rk0ccMaterialColour()[900]),
    textTheme: GoogleFonts.robotoTextTheme());

final ThemeData rk0ccDarkTheme = ThemeData.dark().copyWith(
    primaryColor: const Rk0ccMaterialColour()[600],
    disabledColor: const Rk0ccMaterialColour()[800],
    drawerTheme:
        DrawerThemeData(backgroundColor: const Rk0ccMaterialColour()[900]),
    appBarTheme: AppBarTheme(
        backgroundColor: const Rk0ccMaterialColour()[600],
        foregroundColor: const Rk0ccMaterialColour()[50]),
    textTheme: GoogleFonts.robotoTextTheme().copyWith(
        bodyText1: const TextStyle(color: Colors.white),
        bodyText2: const TextStyle(color: Colors.white),
        headline1: const TextStyle(color: Colors.white),
        headline2: const TextStyle(color: Colors.white),
        headline3: const TextStyle(color: Colors.white),
        headline4: const TextStyle(color: Colors.white),
        headline5: const TextStyle(color: Colors.white),
        headline6: const TextStyle(color: Colors.white),
        caption: const TextStyle(color: Colors.white),
        overline: const TextStyle(color: Colors.white),
        subtitle1: const TextStyle(color: Colors.white),
        subtitle2: const TextStyle(color: Colors.white)));
