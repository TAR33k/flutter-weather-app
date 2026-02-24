import 'package:flutter/material.dart';
import '../config/app_constants.dart';
import '../models/current_weather_model.dart';

class StatsRow extends StatelessWidget {
  final CurrentWeatherModel weather;

  const StatsRow({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
    final windKmh = (weather.windSpeed * 3.6).round();

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AppConstants.spacingMd),
      padding: const EdgeInsets.symmetric(
        horizontal: AppConstants.spacingMd,
        vertical: AppConstants.spacingMd,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(AppConstants.radiusMd),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.shadow,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _StatItem(
            label: 'Feels like',
            value: '${weather.feelsLike.round()}°',
          ),
          _VerticalDivider(),
          _StatItem(label: 'Humidity', value: '${weather.humidity}%'),
          _VerticalDivider(),
          _StatItem(label: 'Wind', value: '$windKmh km/h'),
        ],
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
      color: Theme.of(context).dividerTheme.color!,
    );
  }
}
