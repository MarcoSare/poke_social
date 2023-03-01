import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:poke_social/settings/shared_preferences_settings.dart';
import 'package:provider/provider.dart';

import '../provider/theme_provider.dart';

class ScreenSettings extends StatefulWidget {
  const ScreenSettings({super.key});

  @override
  State<ScreenSettings> createState() => _ScreenSettingsState();
}

class _ScreenSettingsState extends State<ScreenSettings> {
  SharePrefSettings sharePrefSettings = SharePrefSettings();

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Theme.of(context).primaryColor),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.all(20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text(
            "Screen",
            textAlign: TextAlign.end,
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          const Text("COLOR SCHEME"),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              cardColorScheme(
                  "light_theme.jpg", !themeProvider.isDarkMode, false),
              cardColorScheme("dark_theme.jpg", themeProvider.isDarkMode, true),
            ],
          ),
          Container(
            height: 50,
            width: 150,
            padding: const EdgeInsets.only(right: 5, left: 5),
            decoration: BoxDecoration(
                color: Colors.red, borderRadius: BorderRadius.circular(30)),
            child: Row(children: [
              Image.asset(
                "assets/images/types/type_fighting.png",
                height: 40,
                width: 40,
                fit: BoxFit.fill,
              ),
              SizedBox(
                width: 5,
              ),
              Text("Fighting",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold))
            ]),
          )
        ]),
      ),
    );
  }

  Widget cardColorScheme(String image, bool isActive, bool isDark) {
    // !themeProvider.isDarkMode
    return GestureDetector(
      onTap: () async {
        final provider = Provider.of<ThemeProvider>(context, listen: false);
        if (isDark) {
          provider.toggleTheme(true);
          await sharePrefSettings.setTheme(true);
        } else {
          provider.toggleTheme(false);
          await sharePrefSettings.setTheme(false);
        }
      },
      child: Column(
        children: [
          AnimatedContainer(
            duration: Duration(seconds: 2),
            width: 150,
            height: 250,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: isActive ? BorderRadius.circular(10.0) : null,
              border: isActive
                  ? Border.all(
                      color: Theme.of(context).primaryColor,
                      style: BorderStyle.solid,
                      width: 2.0,
                    )
                  : null,
            ),
            child: Container(
              width: 150,
              height: 250,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/$image"),
                    fit: BoxFit.fill),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            isDark ? "Dark mode" : "Light mode",
            style: TextStyle(
                color: isActive ? Theme.of(context).primaryColor : null),
          )
        ],
      ),
    );
  }
}
