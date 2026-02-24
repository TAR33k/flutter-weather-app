import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'config/app_theme.dart';
import 'providers/location_weather_provider.dart';
import 'services/location_service.dart';
import 'services/weather_service.dart';

void main() {
  runApp(const WeatherApp());
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LocationWeatherProvider(
        weatherService: WeatherService(),
        locationService: LocationService(),
      ),
      child: MaterialApp(
        title: 'Weather App',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.theme,
        home: const Scaffold(body: Center(child: Text('Weather App'))),
      ),
    );
  }
}
