import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

const kThemeModeKey = '__theme_mode__';
SharedPreferences? _prefs;

abstract class AppTheme {
  static Future initialize() async =>
      _prefs = await SharedPreferences.getInstance();

  static ThemeMode get themeMode {
    final darkMode = _prefs?.getBool(kThemeModeKey);
    return darkMode == null
        ? ThemeMode.system
        : darkMode
            ? ThemeMode.dark
            : ThemeMode.light;
  }

  static void saveThemeMode(ThemeMode mode) => mode == ThemeMode.system
      ? _prefs?.remove(kThemeModeKey)
      : _prefs?.setBool(kThemeModeKey, mode == ThemeMode.dark);

  static AppTheme of(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? DarkModeTheme()
        : LightModeTheme();
  }

  late Color primary;
  late Color secondary;
  late Color tertiary;
  late Color alternate;
  late Color primaryText;
  late Color secondaryText;
  late Color primaryBackground;
  late Color secondaryBackground;
  late Color tertiaryBackground;

  TextStyle get titleLarge => typography.titleLarge;

  TextStyle get titleMedium => typography.titleMedium;

  TextStyle get titleSmall => typography.titleSmall;

  TextStyle get labelLarge => typography.labelLarge;

  TextStyle get labelMedium => typography.labelMedium;

  TextStyle get labelSmall => typography.labelSmall;

  TextStyle get primaryLarge => typography.primaryLarge;

  TextStyle get primaryMedium => typography.primaryMedium;

  TextStyle get primarySmall => typography.primarySmall;

  Typography get typography => ThemeTypography(this);
}

class LightModeTheme extends AppTheme {
  late Color primary = const Color(0xFF0ABAB5);
  late Color secondary = const Color.fromARGB(255, 6, 111, 108);
  late Color tertiary = const Color(0xFF828282);
  late Color primaryText = const Color(0xFF000000);
  late Color secondaryText = const Color(0xFF414141);
  late Color primaryBackground = const Color(0xFFFFFFFF);
  late Color secondaryBackground = const Color(0xFFF5F5F5);
  late Color tertiaryBackground = const Color.fromARGB(73, 11, 236, 228);
}

abstract class Typography {
  TextStyle get titleLarge;

  TextStyle get titleMedium;

  TextStyle get titleSmall;

  TextStyle get labelLarge;

  TextStyle get labelMedium;

  TextStyle get labelSmall;

  TextStyle get primaryLarge;

  TextStyle get primaryMedium;

  TextStyle get primarySmall;
}

class ThemeTypography extends Typography {
  ThemeTypography(this.theme);

  final AppTheme theme;

  TextStyle get titleLarge => TextStyle(
        fontFamily: 'Inter',
        color: theme.primary,
        fontSize: 21,
        fontWeight: FontWeight.bold,
      );

  TextStyle get titleMedium => TextStyle(
        fontFamily: 'Inter',
        color: theme.primary,
        fontWeight: FontWeight.w700,
        fontSize: 16.0,
      );

  TextStyle get titleSmall => TextStyle(
        fontFamily: 'Inter',
        color: theme.primary,
        fontWeight: FontWeight.w500,
        fontSize: 14.0,
      );

  TextStyle get labelLarge => TextStyle(
        fontFamily: 'Inter',
        color: theme.tertiary,
        fontWeight: FontWeight.w500,
        fontSize: 22.0,
      );

  TextStyle get labelMedium => TextStyle(
        fontFamily: 'Inter',
        color: theme.tertiary,
        fontWeight: FontWeight.w500,
        fontSize: 18.0,
      );

  TextStyle get labelSmall => TextStyle(
        fontFamily: 'Inter',
        color: theme.tertiary,
        fontWeight: FontWeight.w400,
        fontSize: 16.0,
      );

  TextStyle get primaryLarge => TextStyle(
        fontFamily: 'Inter',
        color: theme.primaryText,
        fontWeight: FontWeight.w500,
        fontSize: 16.0,
      );

  TextStyle get primaryMedium => TextStyle(
        fontFamily: 'Inter',
        color: theme.primaryText,
        fontWeight: FontWeight.normal,
        fontSize: 14.0,
      );

  TextStyle get primarySmall => TextStyle(
        fontFamily: 'Inter',
        color: theme.primaryText,
        fontWeight: FontWeight.w300,
        fontSize: 12.0,
      );
}

class DarkModeTheme extends AppTheme {
  late Color primary = const Color(0xFF0ABAB5);
  late Color secondary = const Color.fromARGB(255, 6, 111, 108);
  late Color tertiary = const Color(0xFF828282);
  late Color primaryText = const Color(0xFF000000);
  late Color secondaryText = const Color(0xFF414141);
  late Color primaryBackground = const Color(0xFFFFFFFF);
  late Color secondaryBackground = const Color(0xFFF5F5F5);
  late Color tertiaryBackground = const Color.fromARGB(73, 11, 236, 228);
}
