class ForecastDayModel {
  final DateTime date;

  final double temperature;

  final double minTemp;

  final double maxTemp;

  final String description;

  final String iconCode;

  const ForecastDayModel({
    required this.date,
    required this.temperature,
    required this.minTemp,
    required this.maxTemp,
    required this.description,
    required this.iconCode,
  });
}
