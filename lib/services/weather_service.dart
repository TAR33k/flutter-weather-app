import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config/api_config.dart';
import '../models/current_weather_model.dart';
import '../models/forecast_day_model.dart';
import '../models/forecast_response_model.dart';
import '../models/weather_exception.dart';

class WeatherService {
  Future<CurrentWeatherModel> getCurrentWeatherByCoords(
    double lat,
    double lon,
  ) async {
    final url =
        '${ApiConfig.baseUrl}/weather?lat=$lat&lon=$lon&appid=${ApiConfig.apiKey}&units=metric';
    final response = await _get(url);
    return CurrentWeatherModel.fromJson(response);
  }

  Future<CurrentWeatherModel> getCurrentWeatherByCity(String city) async {
    final url =
        '${ApiConfig.baseUrl}/weather?q=${Uri.encodeComponent(city)}&appid=${ApiConfig.apiKey}&units=metric';
    final response = await _get(url, cityName: city);
    return CurrentWeatherModel.fromJson(response);
  }

  Future<List<ForecastDayModel>> getForecastByCoords(
    double lat,
    double lon,
  ) async {
    final url =
        '${ApiConfig.baseUrl}/forecast?lat=$lat&lon=$lon&appid=${ApiConfig.apiKey}&units=metric';
    final response = await _get(url);
    return _parseForecast(response);
  }

  Future<List<ForecastDayModel>> getForecastByCity(String city) async {
    final url =
        '${ApiConfig.baseUrl}/forecast?q=${Uri.encodeComponent(city)}&appid=${ApiConfig.apiKey}&units=metric';
    final response = await _get(url, cityName: city);
    return _parseForecast(response);
  }

  // Helpers
  Future<Map<String, dynamic>> _get(String url, {String? cityName}) async {
    final response = await http.get(Uri.parse(url));

    switch (response.statusCode) {
      case 200:
        return json.decode(response.body) as Map<String, dynamic>;
      case 401:
        throw const ApiKeyException();
      case 404:
        throw CityNotFoundException(cityName ?? 'Unknown');
      default:
        throw WeatherApiException(response.statusCode);
    }
  }

  /// Parses the forecast API response into daily summaries
  /// The /forecast endpoint returns 40 entries, one per 3 hours
  List<ForecastDayModel> _parseForecast(Map<String, dynamic> json) {
    final forecastResponse = ForecastResponseModel.fromJson(json);
    final entries = forecastResponse.list;

    /// Group entries by date
    final Map<String, List<ForecastEntryModel>> grouped = {};
    for (final entry in entries) {
      final key = entry.dateKey;
      grouped.putIfAbsent(key, () => []).add(entry);
    }

    final List<ForecastDayModel> forecastDays = [];

    // Sort the dates chronologically
    final sortedKeys = grouped.keys.toList()..sort();

    for (final dateKey in sortedKeys) {
      final dayEntries = grouped[dateKey]!;

      // Find the midday entry
      final midday = dayEntries.firstWhere(
        (e) => e.isMidday,
        orElse: () => dayEntries.first,
      );

      // Calculate min and max across all entries for this day
      final minTemp = dayEntries
          .map((e) => e.tempMin)
          .reduce((a, b) => a < b ? a : b);
      final maxTemp = dayEntries
          .map((e) => e.tempMax)
          .reduce((a, b) => a > b ? a : b);

      final date = DateTime.parse(dateKey);

      forecastDays.add(
        ForecastDayModel(
          date: date,
          temperature: midday.temp,
          minTemp: minTemp,
          maxTemp: maxTemp,
          description: midday.description,
          iconCode: midday.iconCode,
        ),
      );

      if (forecastDays.length == 5) break;
    }

    return forecastDays;
  }
}
