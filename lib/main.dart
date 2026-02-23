import 'package:flutter/material.dart';
import 'config/app_theme.dart';

void main() {
  runApp(const WeatherApp());
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.theme,
      home: const Scaffold(body: Center(child: Text('Weather App'))),
    );
  }
}
