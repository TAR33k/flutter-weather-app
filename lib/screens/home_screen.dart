import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../config/app_constants.dart';
import '../models/weather_status.dart';
import '../providers/location_weather_provider.dart';
import '../widgets/app_error_widget.dart';
import '../widgets/current_conditions_card.dart';
import '../widgets/five_day_forecast.dart';
import '../widgets/loading_widget.dart';
import '../widgets/stats_row.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<LocationWeatherProvider>().fetchLocationWeather();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<LocationWeatherProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            tooltip: 'Search city',
            onPressed: () => Navigator.pushNamed(context, '/search'),
          ),
        ],
      ),
      body: _buildBody(provider),
    );
  }

  Widget _buildBody(LocationWeatherProvider provider) {
    switch (provider.status) {
      case WeatherStatus.initial:
      case WeatherStatus.loading:
        return const LoadingWidget();

      case WeatherStatus.error:
        return AppErrorWidget(
          message: provider.errorMessage ?? 'Something went wrong.',
          onRetry: () =>
              context.read<LocationWeatherProvider>().fetchLocationWeather(),
        );

      case WeatherStatus.loaded:
        return RefreshIndicator(
          onRefresh: () =>
              context.read<LocationWeatherProvider>().fetchLocationWeather(),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.only(
                bottom: AppConstants.spacingXl,
                top: AppConstants.spacingMd,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  CurrentConditionsCard(weather: provider.currentWeather!),
                  const SizedBox(height: AppConstants.spacingXl),
                  StatsRow(weather: provider.currentWeather!),
                  const SizedBox(height: AppConstants.spacingXl),
                  FiveDayForecast(forecast: provider.forecast),
                ],
              ),
            ),
          ),
        );
    }
  }
}
