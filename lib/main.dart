import 'package:clima_guard_mobile/CustomTheme.dart';
import 'package:clima_guard_mobile/views/RouteInputScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  await dotenv.load(fileName: '.env');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ClimaGuard',
      themeMode: ThemeMode.system,
      theme: CustomTheme.lightThemeData(),
      darkTheme: CustomTheme.darkThemeData(),
      home: RouteInputScreen(),
    );
  }
}
