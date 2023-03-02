import 'package:flutter/material.dart';
import 'package:poke_social/provider/theme_provider.dart';
import 'package:poke_social/routes.dart';
import 'package:poke_social/screens/login_screen.dart';
import 'package:poke_social/screens/onboarding_screen.dart';
import 'package:poke_social/screens/welcome_screen.dart';
import 'package:poke_social/settings/shared_preferences_settings.dart';
import 'package:poke_social/settings/styles_settings.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int? themeKey = 0;
  SharePrefSettings sharePrefSettings = SharePrefSettings();

  @override
  Widget build(BuildContext context) => FutureBuilder(
      future: getTheme(),
      // ignore: avoid_types_as_parameter_names
      builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
        if (snapshot.hasData) {
          return ChangeNotifierProvider(
              create: (context) => ThemeProvider()..init(themeKey!),
              builder: (context, _) {
                final themeProvider = Provider.of<ThemeProvider>(context);
                return MaterialApp(
                  debugShowCheckedModeBanner: false,
                  routes: getAplicationRoutes(),
                  themeMode: themeProvider.themeMode,
                  theme: themeProvider.themeKey == 0
                      ? myThemes.lightTheme
                      : myThemes.warmTheme,
                  darkTheme: myThemes.darkTheme,
                  title: 'Poke Social',
                  home: WelcomeScreen(),
                );
              });
        } else {
          return const Center(
              child: Center(
                  child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
          )));
        }
      });

  Future<int> getTheme() async {
    themeKey = (await sharePrefSettings.getTheme());
    print(themeKey);
    if (themeKey == null) themeKey = 0;
    return themeKey!;
  }
}
/*
ChangeNotifierProvider(
        create: (context) => ThemeProvider()..init(themeKey),
        builder: (context, _) {
          final themeProvider = Provider.of<ThemeProvider>(context);
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            routes: getAplicationRoutes(),
            themeMode: themeProvider.themeMode,
            theme: myThemes.lightTheme,
            darkTheme: myThemes.darkTheme,
            title: 'Poke Social',
            home: WelcomeScreen(),
          );
        });*/