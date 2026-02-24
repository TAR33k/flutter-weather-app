import 'package:flutter/material.dart';
import '../config/api_config.dart';
import '../config/app_constants.dart';
import '../models/current_weather_model.dart';

class CurrentConditionsCard extends StatelessWidget {
  final CurrentWeatherModel weather;

  const CurrentConditionsCard({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppConstants.spacingMd),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppConstants.spacingLg,
            vertical: AppConstants.spacingLg,
          ),
          child: Column(
            children: [
              Text(
                '${weather.cityName}, ${weather.country}',
                style: textTheme.displayMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppConstants.spacingSm),
              Image.network(
                ApiConfig.iconUrl(weather.iconCode),
                width: AppConstants.weatherIconSize,
                height: AppConstants.weatherIconSize,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return SizedBox(
                    width: AppConstants.weatherIconSize,
                    height: AppConstants.weatherIconSize,
                  );
                },
                errorBuilder: (context, error, stackTrace) {
                  return SizedBox(
                    width: AppConstants.weatherIconSize,
                    height: AppConstants.weatherIconSize,
                  );
                },
              ),
              Text(
                '${weather.temperature.round()}°',
                style: textTheme.displaySmall,
              ),
              const SizedBox(height: AppConstants.spacingXs),
              Text(
                _capitalise(weather.description),
                style: textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _capitalise(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1);
  }
}
