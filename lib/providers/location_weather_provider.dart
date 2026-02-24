import 'package:flutter/material.dart';
import '../models/current_weather_model.dart';
import '../models/forecast_day_model.dart';
import '../models/weather_exception.dart';
import '../models/weather_status.dart';
import '../services/location_service.dart';
import '../services/weather_service.dart';

class LocationWeatherProvider extends ChangeNotifier {
  final WeatherService _weatherService;
  final LocationService _locationService;

  LocationWeatherProvider({
    required WeatherService weatherService,
    required LocationService locationService,
  }) : _weatherService = weatherService,
       _locationService = locationService;

  WeatherStatus _status = WeatherStatus.initial;
  CurrentWeatherModel? _currentWeather;
  List<ForecastDayModel> _forecast = [];
  String? _errorMessage;

  WeatherStatus get status => _status;
  CurrentWeatherModel? get currentWeather => _currentWeather;
  List<ForecastDayModel> get forecast => _forecast;
  String? get errorMessage => _errorMessage;

  Future<void> fetchLocationWeather() async {
    _status = WeatherStatus.loading;
    _errorMessage = null;
    notifyListeners();

    try {
      final position = await _locationService.getCurrentPosition();

      final results = await Future.wait([
        _weatherService.getCurrentWeatherByCoords(
          position.latitude,
          position.longitude,
        ),
        _weatherService.getForecastByCoords(
          position.latitude,
          position.longitude,
        ),
      ]);

      _currentWeather = results[0] as CurrentWeatherModel;
      _forecast = results[1] as List<ForecastDayModel>;
      _status = WeatherStatus.loaded;
    } on LocationServiceDisabledException catch (e) {
      _errorMessage = e.message;
      _status = WeatherStatus.error;
    } on LocationPermissionDeniedException catch (e) {
      _errorMessage = e.message;
      _status = WeatherStatus.error;
    } on LocationPermissionPermanentlyDeniedException catch (e) {
      _errorMessage = e.message;
      _status = WeatherStatus.error;
    } on WeatherException catch (e) {
      _errorMessage = e.message;
      _status = WeatherStatus.error;
    } catch (e) {
      _errorMessage = 'Error';
      _status = WeatherStatus.error;
    }
  }
}
