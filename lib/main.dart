import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/screens/home_screen.dart';
import 'config/app_theme.dart';
import 'providers/city_weather_provider.dart';
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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => LocationWeatherProvider(
            weatherService: WeatherService(),
            locationService: LocationService(),
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => CityWeatherProvider(weatherService: WeatherService()),
        ),
      ],
      child: MaterialApp(
        title: 'Weather App',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.theme,
        initialRoute: "/",
        routes: {"/": (context) => const HomeScreen()},
      ),
    );
  }
}
