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
        padding: const EdgeInsets.all(20),
        child: ListView(shrinkWrap: true, children: [
          const Text(
            "Screen",
            textAlign: TextAlign.start,
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          const Text("COLOR SCHEME"),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              cardColorScheme(
                  "light_theme.jpg", themeProvider.getTheme == 0, 0),
              cardColorScheme("dark_theme.jpg", themeProvider.getTheme == 1, 1),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              cardColorScheme("warm_theme.jpg", themeProvider.getTheme == 2, 2),
            ],
          ),
          const SizedBox(height: 10),
          Text("COLOR PALETTE"),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            primary: false,
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            crossAxisCount: 2,
            children: <Widget>[
              cardType("assets/images/types/type_bug.png", "Bug", Colors.green),
              cardType(
                  "assets/images/types/type_dark.png", "Dark", Colors.black26),
              cardType("assets/images/types/type_dragon.png", "Dragon",
                  Colors.blueAccent),
              cardType("assets/images/types/type_electric.png", "Electric",
                  Colors.yellowAccent),
              cardType("assets/images/types/type_fairy.png", "Bug",
                  Colors.pinkAccent),
            ],
          ),
        ]),
      ),
    );
  }

  Widget cardColorScheme(String image, bool isActive, int theme) {
    List<String> title = ["Light mode", "Dark mode", "Warm mode"];
    // !themeProvider.isDarkMode
    /* 
    theme == 0 light
    theme == 1 dark
    theme == 2
    */
    return GestureDetector(
      onTap: () async {
        final provider = Provider.of<ThemeProvider>(context, listen: false);

        switch (theme) {
          case 0:
            provider.toggleTheme(false, 0);
            await sharePrefSettings.setTheme(0);
            print("gf");
            break;
          case 1:
            provider.toggleTheme(true, 1);
            await sharePrefSettings.setTheme(1);
            break;
          case 2:
            provider.toggleTheme(false, 2);
            await sharePrefSettings.setTheme(2);
            break;
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
            title[theme],
            style: TextStyle(
                color: isActive ? Theme.of(context).primaryColor : null),
          )
        ],
      ),
    );
  }

  Widget cardType(String image, String type, Color color) {
    return Container(
      height: 50,
      width: 150,
      padding: const EdgeInsets.only(right: 5, left: 5),
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(30)),
      child: Row(children: [
        Image.asset(
          image,
          height: 40,
          width: 40,
          fit: BoxFit.fill,
        ),
        const SizedBox(
          width: 5,
        ),
        Text(type,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold))
      ]),
    );
  }
}
