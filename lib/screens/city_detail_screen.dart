import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../config/app_constants.dart';
import '../providers/city_weather_provider.dart';
import '../widgets/app_error_widget.dart';
import '../widgets/current_conditions_card.dart';
import '../widgets/five_day_forecast.dart';
import '../widgets/loading_widget.dart';
import '../widgets/stats_row.dart';
import '../models/weather_status.dart';

class CityDetailScreen extends StatelessWidget {
  const CityDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<CityWeatherProvider>();
    final appBarTitle = provider.currentWeather != null
        ? '${provider.currentWeather!.cityName}, ${provider.currentWeather!.country}'
        : '';

    return Scaffold(
      appBar: AppBar(title: Text(appBarTitle)),
      body: _buildBody(context, provider),
    );
  }

  Widget _buildBody(BuildContext context, CityWeatherProvider provider) {
    switch (provider.status) {
      case WeatherStatus.initial:
      case WeatherStatus.loading:
        return const LoadingWidget();

      case WeatherStatus.error:
        return AppErrorWidget(
          message: provider.errorMessage ?? 'Something went wrong.',
          onRetry: () => context.read<CityWeatherProvider>().refresh(),
        );

      case WeatherStatus.loaded:
        final weather = provider.currentWeather!;
        final forecast = provider.forecast;
        final visibilityKm = (weather.visibility / 1000).toStringAsFixed(1);

        return RefreshIndicator(
          onRefresh: () => context.read<CityWeatherProvider>().refresh(),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.only(bottom: AppConstants.spacingXl),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  CurrentConditionsCard(weather: weather),
                  const SizedBox(height: AppConstants.spacingXl),
                  StatsRow(weather: weather),
                  const SizedBox(height: AppConstants.spacingXl),
                  FiveDayForecast(forecast: forecast),
                  const SizedBox(height: AppConstants.spacingXl),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppConstants.spacingMd,
                    ),
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(AppConstants.spacingLg),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    'Details',
                                    style: Theme.of(
                                      context,
                                    ).textTheme.titleMedium,
                                  ),
                                ),
                                Icon(
                                  Icons.info_outline_rounded,
                                  size: AppConstants.iconSm,
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.onSurface,
                                ),
                              ],
                            ),
                            const SizedBox(height: AppConstants.spacingSm),
                            const Divider(height: 1),
                            const SizedBox(height: AppConstants.spacingSm),
                            _WeatherDetailRow(
                              label: 'Pressure',
                              value: '${weather.pressure} hPa',
                            ),
                            _WeatherDetailRow(
                              label: 'Visibility',
                              value: '$visibilityKm km',
                            ),
                            _WeatherDetailRow(
                              label: 'Wind Speed',
                              value: '${weather.windSpeed} m/s',
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
    }
  }
}

class _WeatherDetailRow extends StatelessWidget {
  final String label;
  final String value;

  const _WeatherDetailRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: AppConstants.spacingMd),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(label, style: textTheme.bodyMedium),
              Text(value, style: textTheme.bodyLarge),
            ],
          ),
        ),
        const Divider(height: 1),
      ],
    );
  }
}
