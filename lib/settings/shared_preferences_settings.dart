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

  Future<void> setTheme(int theme) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setInt('theme', theme); //true=> oscuro, false =>claro
  }

  Future<int?> getTheme() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if (preferences.containsKey('theme')) {
      return preferences.getInt('theme');
    } else {
      0;
    }
  }
}
