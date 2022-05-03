import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox("setting");

  runApp(const Rk0ccStatus());
}

class Rk0ccStatus extends StatelessWidget {
  const Rk0ccStatus({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => ValueListenableBuilder<Box>(
      valueListenable: Hive.box("setting").listenable(keys: ["theme_mode"]),
      builder: (context, box, child) => MaterialApp(
            themeMode: box.get("dark_mode", defaultValue: false)
                ? ThemeMode.dark
                : ThemeMode.light,
          ));
}

class Rk0ccStatusPage extends StatelessWidget {
  const Rk0ccStatusPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => SafeArea(
          child: Scaffold(
        appBar: AppBar(title: Text("rk0cc.xyz API server status")),
      ));
}
