import 'package:flutter/material.dart';
import 'package:poke_social/routes.dart';
import 'package:poke_social/screens/login_screen.dart';
import 'package:poke_social/settings/styles_settings.dart';

void main() => runApp( MyApp());

class MyApp extends StatelessWidget {
  MyApp({super.key});
  int contador=0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: getAplicationRoutes(),
      theme: myTheme,
      title: 'Poke Social',
      home: LoginScreen(),
    );
  }
}