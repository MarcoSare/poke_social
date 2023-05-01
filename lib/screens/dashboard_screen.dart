import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:poke_social/models/user_model.dart';
import 'package:poke_social/settings/user_preferences.dart';
import 'package:provider/provider.dart';

import '../provider/theme_provider.dart';

class DashBoardScreen extends StatefulWidget {
  UserModel user;
  DashBoardScreen({super.key, required this.user});

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Hola ${widget.user.firstName}"),
        actions: <Widget>[
          Container(
            width: 50,
            height: 50,
            margin: const EdgeInsets.all(5),
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(widget.user.profilePicture!),
                    fit: BoxFit.cover),
                shape: BoxShape.circle),
          ),
        ],
      ),
      body: Container(),
      drawer: Drawer(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              Container(
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(
                            "https://i.blogs.es/2e39a5/anniversaryposter2019/840_560.jpeg"),
                        fit: BoxFit.cover)),
                child: UserAccountsDrawerHeader(
                  accountName: Text(widget.user.firstName!),
                  accountEmail: Text(widget.user.email!),
                  currentAccountPicture: Container(
                    width: 50,
                    height: 50,
                    margin: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(widget.user.profilePicture!),
                            fit: BoxFit.cover),
                        shape: BoxShape.circle),
                  ),
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.black, Colors.black26],
                  )),
                ),
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
              ListTile(
                  title: const Text(
                    'Events',
                  ),
                  leading: const Icon(
                    Icons.calendar_month,
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, '/events');
                  }),
              ListTile(
                  title: const Text(
                    'Pokedex',
                  ),
                  leading: const Icon(
                    Icons.catching_pokemon_sharp,
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, '/pokedex');
                  }),
              ListTile(
                  title: const Text(
                    'LogOut',
                  ),
                  leading: const Icon(
                    Icons.logout,
                  ),
                  onTap: () async {
                    UserPreferences userPreferences = UserPreferences();
                    String? provider = await userPreferences.getProvider();
                    if (provider != null) {
                      if (provider == "google") {
                        final GoogleSignIn googleSignIn = GoogleSignIn();
                        googleSignIn.disconnect();
                      } else if (provider == "facebook") {
                        await FacebookAuth.instance.logOut();
                      }
                    }
                    await userPreferences.logOut();
                    Navigator.pushNamed(context, '/login');
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
