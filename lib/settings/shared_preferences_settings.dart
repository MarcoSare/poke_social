import 'package:shared_preferences/shared_preferences.dart';

class SharePrefSettings {
  Future<void> bienvenida() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setBool('bienvenida', true);
  }

  Future<bool?> getbienvenida() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if (preferences.containsKey('bienvenida'))
      return await preferences.getBool('bienvenida');
    else
      false;
  }

  Future<void> setTheme(bool theme) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setBool('theme', theme); //true=> oscuro, false =>claro
  }

  Future<bool?> getTheme() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if (preferences.containsKey('theme')) {
      return preferences.getBool('theme');
    } else {
      false;
    }
  }
}
