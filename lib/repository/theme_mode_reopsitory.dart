import 'package:flutter/material.dart';
import 'package:flutter_kids_qa/shared_preferences/shared_preferences_instance.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ThemeModeNotifier extends StateNotifier<ThemeMode> {
  static const String keyThemeMode = 'theme_mode';

  final prefs = SharedPreferencesInstance().prefs;

  ThemeModeNotifier() : super(ThemeMode.system) {
    state = _loadThemeMode() ?? ThemeMode.system;
  }

  Future<void> toggle() async {
    ThemeMode themeMode;
    switch (state) {
      case ThemeMode.light:
        themeMode = ThemeMode.dark;
        break;
      case ThemeMode.dark:
        themeMode = ThemeMode.system;
        break;
      case ThemeMode.system:
        themeMode = ThemeMode.light;
        break;
      default:
        throw UnimplementedError();
    }
    await _saveThemeMode(themeMode).then((value) {
      if (value == true) {
        state = themeMode;
      }
    });
  }

  ThemeMode? _loadThemeMode() {
    final loaded = prefs.getString(keyThemeMode);
    if (loaded == null) {
      return null;
    }
    return ThemeMode.values.byName(loaded);
  }

  Future<bool> _saveThemeMode(ThemeMode themeMode) => prefs.setString(keyThemeMode, themeMode.name);
}

final themeModeProvider = StateNotifierProvider<ThemeModeNotifier, ThemeMode>((ref) => ThemeModeNotifier());
