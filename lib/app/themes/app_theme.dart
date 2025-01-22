import 'package:flutter/material.dart';
part './app_palette.dart';

final ThemeData appLightTheme = ThemeData(
  fontFamily: "Montserrat",
  primaryColor: AppPalette.primary.base,
  primaryColorLight: AppPalette.primary.light,
  primaryColorDark: AppPalette.primary.dark,
  brightness: Brightness.light,
  canvasColor: const Color(0xFFFFF3EA),
  colorScheme: ThemeData.light().colorScheme.copyWith(
        primary: AppPalette.primary.base,
        onPrimary: AppPalette.white.base,
        primaryContainer: AppPalette.primary.light,
        onPrimaryContainer: AppPalette.primary.dark,
        inversePrimary: AppPalette.primary.extraLight,
        secondary: AppPalette.secondary.base,
        onSecondary: AppPalette.black.base,
        secondaryContainer: AppPalette.secondary.light,
        onSecondaryContainer: AppPalette.secondary.dark,
        tertiary: AppPalette.black.base,
        onTertiary: AppPalette.white.base,
        onTertiaryContainer: AppPalette.secondary.light,
        error: AppPalette.danger.base,
        onError: AppPalette.white.base,
        errorContainer: AppPalette.danger.light,
        onErrorContainer: AppPalette.danger.dark,
      ),
  cardColor: AppPalette.white.base,
  appBarTheme: ThemeData.light().appBarTheme.copyWith(
        elevation: 0,
        backgroundColor: AppPalette.white.light,
        foregroundColor: AppPalette.black.base,
      ),
);
