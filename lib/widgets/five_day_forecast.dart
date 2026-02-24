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
                      '5-Day Forecast',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                  Icon(
                    Icons.calendar_month_rounded,
                    color: Theme.of(context).colorScheme.onSurface,
                    size: AppConstants.iconSm,
                  ),
                ],
              ),
              const SizedBox(height: AppConstants.spacingSm),
              const Divider(height: 1),
              const SizedBox(height: AppConstants.spacingSm),
              ...forecast.map((day) => ForecastCard(forecast: day)),
            ],
          ),
        ),
      ),
    );
  }
}
