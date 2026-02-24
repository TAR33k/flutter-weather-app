import 'package:flutter/material.dart';
import '../models/current_weather_model.dart';
import '../models/forecast_day_model.dart';
import '../models/weather_exception.dart';
import '../models/weather_status.dart';
import '../services/weather_service.dart';

class CityWeatherProvider extends ChangeNotifier {
  final WeatherService _weatherService;

  CityWeatherProvider({required WeatherService weatherService})
    : _weatherService = weatherService;

  WeatherStatus _status = WeatherStatus.initial;
  CurrentWeatherModel? _currentWeather;
  List<ForecastDayModel> _forecast = [];
  String? _errorMessage;
  String? _lastSearchedCity;

  WeatherStatus get status => _status;
  CurrentWeatherModel? get currentWeather => _currentWeather;
  List<ForecastDayModel> get forecast => _forecast;
  String? get errorMessage => _errorMessage;

  Future<void> fetchCityWeather(String city) async {
    _status = WeatherStatus.loading;
    _errorMessage = null;
    notifyListeners();

    try {
      final results = await Future.wait([
        _weatherService.getCurrentWeatherByCity(city),
        _weatherService.getForecastByCity(city),
      ]);

      _currentWeather = results[0] as CurrentWeatherModel;
      _forecast = results[1] as List<ForecastDayModel>;
      _lastSearchedCity = city;
      _status = WeatherStatus.loaded;
    } on CityNotFoundException catch (e) {
      _errorMessage = e.message;
      _status = WeatherStatus.error;
    } on WeatherException catch (e) {
      _errorMessage = e.message;
      _status = WeatherStatus.error;
    } catch (e) {
      _errorMessage = 'Error';
      _status = WeatherStatus.error;
    } finally {
      notifyListeners();
    }
  }

  Future<void> refresh() async {
    if (_lastSearchedCity != null) {
      await fetchCityWeather(_lastSearchedCity!);
    }
  }

  void reset() {
    _status = WeatherStatus.initial;
    _currentWeather = null;
    _forecast = [];
    _errorMessage = null;
    _lastSearchedCity = null;
    notifyListeners();
  }
}
