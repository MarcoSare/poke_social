import 'package:flutter/material.dart';
class ThemeProvider extends ChangeNotifier {
  //appPreferences app_preferences = appPreferences();
  late ThemeMode themeMode;
  late int themeKey;
  bool get isDarkMode => themeMode == ThemeMode.dark;

  int get getTheme => themeKey;

  void toggleTheme(bool isOn, int key) {
    themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
    themeKey = key;
    notifyListeners();
  }

  ThemeMode getThemeMode(bool theme) {
    if (theme == true)
      return themeMode = ThemeMode.dark;
    else
      return themeMode = ThemeMode.light;
  }

  init(int theme) {
    if (theme != null) {
      themeKey = theme;
      themeMode = theme == 1 ? ThemeMode.dark : ThemeMode.light;
    } else
      themeMode = ThemeMode.dark;
    notifyListeners();
  }
}
