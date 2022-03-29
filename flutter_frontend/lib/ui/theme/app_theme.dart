import 'package:flutter/material.dart';

final ThemeData defaultTheme = ThemeData(
    primarySwatch: generateMaterialColor(const Color(0xFF5cb85c)),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    iconTheme: const IconThemeData(color: Color(0xFF5cb85c)),
    appBarTheme: const AppBarTheme(color: Colors.white));

MaterialColor generateMaterialColor(Color color) {
  return MaterialColor(color.value, {
    50: Color.fromRGBO(color.red, color.green, color.blue, 0.1),
    100: Color.fromRGBO(color.red, color.green, color.blue, 0.2),
    200: Color.fromRGBO(color.red, color.green, color.blue, 0.3),
    300: Color.fromRGBO(color.red, color.green, color.blue, 0.4),
    400: Color.fromRGBO(color.red, color.green, color.blue, 0.5),
    500: Color.fromRGBO(color.red, color.green, color.blue, 0.6),
    600: Color.fromRGBO(color.red, color.green, color.blue, 0.7),
    700: Color.fromRGBO(color.red, color.green, color.blue, 0.8),
    800: Color.fromRGBO(color.red, color.green, color.blue, 0.9),
    900: Color.fromRGBO(color.red, color.green, color.blue, 1.0),
  });
}

extension CustomColorSchemeX on ColorScheme {
  Color get rwBrown => const Color.fromARGB(255, 53, 53, 53);

  Color get rwLightGray => const Color.fromARGB(255, 187, 187, 187);

  Color get rwDarkGray => const Color.fromARGB(255, 129, 138, 145);

  Color get rwWhite => const Color.fromARGB(255, 243, 243, 243);

  Color get rwLogoutColor => const Color.fromARGB(255, 184, 92, 92);
}
