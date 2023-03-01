import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/theme_provider.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({super.key});

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      body: Container(),
      drawer: Drawer(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              const UserAccountsDrawerHeader(
                accountName: null,
                accountEmail: null,
                decoration: BoxDecoration(
                    color: Colors.transparent,
                    image: DecorationImage(
                        image: NetworkImage(
                            "https://i.blogs.es/2e39a5/anniversaryposter2019/840_560.jpeg"),
                        fit: BoxFit.cover)),
              ),
              ListTile(
                  title: const Text(
                    'Screen settings',
                  ),
                  leading: const Icon(
                    Icons.brightness_5,
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, '/screenSettings');
                  }),
            ],
          )),
    );
  }
}



/*
Switch.adaptive(
      value: themeProvider.isDarkMode,
     onChanged: (bool value) async {
        await app_preferences.setTheme(value);
        final provider = Provider.of<ThemeProvider>(context, listen: false);
        provider.toggleTheme(value);
     },)*/
