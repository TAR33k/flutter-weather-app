import 'package:flutter/material.dart';
import '../config/app_constants.dart';
import '../models/current_weather_model.dart';

class StatsRow extends StatelessWidget {
  final CurrentWeatherModel weather;

  const StatsRow({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
    final windKmh = (weather.windSpeed * 3.6).round();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppConstants.spacingMd),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppConstants.spacingLg,
            vertical: AppConstants.spacingMd,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _StatItem(
                label: 'Feels like',
                value: '${weather.feelsLike.round()}°',
              ),
              const _VerticalDivider(),
              _StatItem(label: 'Humidity', value: '${weather.humidity}%'),
              const _VerticalDivider(),
              _StatItem(label: 'Wind', value: '$windKmh km/h'),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String label;
  final String value;

  const _StatItem({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(value, style: textTheme.bodyLarge),
        const SizedBox(height: 2),
        Text(label, style: textTheme.bodySmall),
      ],
    );
  }
}

class _VerticalDivider extends StatelessWidget {
  const _VerticalDivider();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 32,
      width: 1,
      color: Theme.of(context).dividerTheme.color,
    );
  }
}
