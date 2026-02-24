import 'package:flutter/material.dart';
import '../config/api_config.dart';
import '../config/app_constants.dart';
import '../models/forecast_day_model.dart';

class ForecastCard extends StatelessWidget {
  final ForecastDayModel forecast;

  const ForecastCard({super.key, required this.forecast});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppConstants.spacingXs),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(_formatDay(forecast.date), style: textTheme.bodyLarge),
          ),
          Expanded(
            flex: 2,
            child: Center(
              child: Image.network(
                ApiConfig.iconUrl(forecast.iconCode),
                width: 36,
                height: 36,
                errorBuilder: (_, __, ___) =>
                    const SizedBox(width: 36, height: 36),
                loadingBuilder: (_, child, progress) => progress == null
                    ? child
                    : const SizedBox(width: 36, height: 36),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  '${forecast.maxTemp.round()}°',
                  style: textTheme.bodyLarge,
                ),
                const SizedBox(width: 8),
                Text(
                  '${forecast.minTemp.round()}°',
                  style: textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatDay(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final forecastDate = DateTime(date.year, date.month, date.day);

    if (forecastDate == today) return 'Today';

    const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return days[date.weekday - 1];
  }
}
