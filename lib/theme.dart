import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const int _rk0ccPrimaryHex = 0xff33ff33;

/// [MaterialColor] set of rk0cc's colour scheme.
const MaterialColor rk0ccMaterialColour =
    MaterialColor(_rk0ccPrimaryHex, const <int, Color>{
  50: Color(0xffedffed),
  100: Color(0xffc9ffc9),
  200: Color(0xff83ff83),
  300: Color(_rk0ccPrimaryHex),
  400: Color(0xff00e400),
  500: Color(0xff00c100),
  600: Color(0xff008c00),
  700: Color(0xff006900),
  800: Color(0xff004600),
  900: Color(0xff002300)
});

/// A [ThemeData] uses on light mode.
final ThemeData rk0ccLightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: rk0ccMaterialColour,
    disabledColor: rk0ccMaterialColour[100],
    drawerTheme: DrawerThemeData(backgroundColor: rk0ccMaterialColour[50]),
    appBarTheme: AppBarTheme(
        backgroundColor: rk0ccMaterialColour,
        foregroundColor: rk0ccMaterialColour[900]),
    textTheme: GoogleFonts.robotoTextTheme());

/// A [ThemeData] uses on dark mode.
final ThemeData rk0ccDarkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: rk0ccMaterialColour[600],
    disabledColor: rk0ccMaterialColour[800],
    drawerTheme: DrawerThemeData(backgroundColor: rk0ccMaterialColour[900]),
    appBarTheme: AppBarTheme(
        backgroundColor: rk0ccMaterialColour[600],
        foregroundColor: rk0ccMaterialColour[50]),
    textTheme: GoogleFonts.robotoTextTheme()
        .apply(bodyColor: Colors.white, displayColor: Colors.white));
