import 'package:flutter/material.dart';
import 'package:poke_social/screens/dashboard_screen.dart';
import 'package:poke_social/screens/login_screen.dart';
import 'package:poke_social/screens/register_screen.dart';
import 'package:poke_social/settings/screen_settings.dart';

Map<String, WidgetBuilder> getAplicationRoutes() {
  return <String, WidgetBuilder>{
    '/login': (BuildContext context) => LoginScreen(),
    '/register': (BuildContext context) => RegisterScreen(),
    '/dashBoard': (BuildContext context) => DashBoardScreen(),
    '/screenSettings': (BuildContext context) => ScreenSettings()
  };
}
