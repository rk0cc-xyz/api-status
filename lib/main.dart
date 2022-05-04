import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:url_launcher/url_launcher.dart' as url_launcher;

import 'status.dart';
import 'theme.dart' show rk0ccLightTheme, rk0ccDarkTheme;

void main() async {
  if (!kIsWeb) {
    // Disallow run as desktop and mobile app.
    throw UnsupportedError(
        "This is a web application, and only run on browser.");
  }

  await Hive.initFlutter();
  Box settingBox = await Hive.openBox("setting");

  // Initalize setting data if no record.
  if (!settingBox.containsKey("dark_mode")) {
    await settingBox.put("dark_mode", false);
  }

  runApp(const Rk0ccStatus());
}

/// Web app entry point of reporting rk0cc.xyz's API status.
class Rk0ccStatus extends StatelessWidget {
  /// Construct the app.
  const Rk0ccStatus({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => ValueListenableBuilder<Box>(
      valueListenable: Hive.box("setting").listenable(),
      builder: (context, box, child) => MaterialApp(
          theme: rk0ccLightTheme,
          darkTheme: rk0ccDarkTheme,
          themeMode: box.get("dark_mode", defaultValue: false)
              ? ThemeMode.dark
              : ThemeMode.light,
          home: Rk0ccStatusPage(hiveSetting: box),
          title: "API server status in rk0cc.xyz"));
}

/// Context uses for rendering API server status.
class Rk0ccStatusPage extends StatelessWidget {
  final Box<dynamic> _hiveSetting;
  final List<APIStatusCard> _statusCards = <APIStatusCard>[
    APIStatusCard(sitemap: <String, String>{
      "GAF entry point": "/github",
      "GAF repository": "/github/repository",
      "GAF language count": "/github/counts/language",
      "GAF license count": "/github/counts/license",
      "GAF topics count": "/github/counts/topics",
      "GAF status": "/github/status"
    }, title: "GAF API")
  ];

  /// Construct the page with [hiveSetting] which come from
  /// [ValueListenableBuilder].
  Rk0ccStatusPage({Key? key, required Box<dynamic> hiveSetting})
      : this._hiveSetting = hiveSetting,
        super(key: key);

  @override
  Widget build(BuildContext context) => SafeArea(
      child: Scaffold(
          appBar: AppBar(
              title: Text("rk0cc.xyz API server status"),
              actions: <IconButton>[
                IconButton(
                    onPressed: () => _hiveSetting.put("dark_mode",
                        !_hiveSetting.get("dark_mode", defaultValue: false)),
                    icon: Icon(Icons.dark_mode,
                        semanticLabel: "Toggle dark mode")),
                IconButton(
                    onPressed: () => openStatusHelp(context),
                    icon: Icon(Icons.help_outline,
                        semanticLabel: "Status indicator help"))
              ]),
          drawer: Drawer(
              child: ListView(padding: EdgeInsets.zero, children: <Widget>[
            DrawerHeader(
                child: Align(
                    alignment: Alignment.topLeft,
                    child: IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.arrow_back,
                            semanticLabel: "Close menu")))),
            ListTile(
                leading: const Icon(Icons.web),
                title: const Text("Back to rk0cc.xyz"),
                onTap: () async {
                  var site = Uri.parse("https://www.rk0cc.xyz");

                  if (await url_launcher.canLaunchUrl(site)) {
                    url_launcher.launchUrl(site);
                  }
                }),
            ListTile(
              leading: Icon(Icons.email_outlined),
              title: const Text("Contact rk0cc"),
              onTap: () async {
                var mail = Uri.parse("mailto:enquiry@rk0cc.xyz");

                if (await url_launcher.canLaunchUrl(mail)) {
                  url_launcher.launchUrl(mail);
                }
              },
            )
          ])),
          body: Center(
              child: Container(
                  margin: const EdgeInsets.only(top: 15),
                  constraints: BoxConstraints(maxWidth: 768),
                  child: ListView(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      children: _statusCards)))));
}
