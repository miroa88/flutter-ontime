//palette.dart
import 'package:flutter/material.dart';
class Palette {
  static const MaterialColor kToDark = const MaterialColor(
    0xff000000, // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch.
    const <int, Color>{
      50: const Color(0xff000000),//100%
      100: const Color(0xff000000),//100%
      200: const Color(0xff000000),//100%
      300: const Color(0xff000000),//100%
      400: const Color(0xff000000),//100%
      500: const Color(0xff000000),//100%
      600: const Color(0xff000000),//100%
      700: const Color(0xff000000),//100%
      800: const Color(0xff000000),//100%
      900: const Color(0xff4b4b4b),//100%
    },
  );
}