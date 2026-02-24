import 'package:flutter/material.dart';
import '../config/app_constants.dart';
import '../models/forecast_day_model.dart';
import 'forecast_card.dart';

class FiveDayForecast extends StatelessWidget {
  final List<ForecastDayModel> forecast;

  const FiveDayForecast({super.key, required this.forecast});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppConstants.spacingMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '5-Day Forecast',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: AppConstants.spacingSm),
          const Divider(height: 1),
          const SizedBox(height: AppConstants.spacingXs),

          ...forecast.map((day) => ForecastCard(forecast: day)),
        ],
      ),
    );
  }
}
