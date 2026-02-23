// ignore_for_file: library_private_types_in_public_api

import 'package:json_annotation/json_annotation.dart';

part 'current_weather_model.g.dart';

@JsonSerializable()
class CurrentWeatherModel {
  @JsonKey(name: 'name')
  final String cityName;

  @JsonKey(name: 'sys')
  final _WeatherSys sys;

  @JsonKey(name: 'main')
  final _WeatherMain main;

  @JsonKey(name: 'wind')
  final _WeatherWind wind;

  @JsonKey(name: 'weather')
  final List<_WeatherCondition> weatherConditions;

  @JsonKey(name: 'visibility')
  final int visibility;

  const CurrentWeatherModel({
    required this.cityName,
    required this.sys,
    required this.main,
    required this.wind,
    required this.weatherConditions,
    required this.visibility,
  });

  // Getters for easy access in the UI
  String get country => sys.country;
  double get temperature => main.temp;
  double get feelsLike => main.feelsLike;
  int get humidity => main.humidity;
  int get pressure => main.pressure;
  double get windSpeed => wind.speed;
  String get description =>
      weatherConditions.isNotEmpty ? weatherConditions.first.description : '';
  String get iconCode =>
      weatherConditions.isNotEmpty ? weatherConditions.first.icon : '';

  factory CurrentWeatherModel.fromJson(Map<String, dynamic> json) =>
      _$CurrentWeatherModelFromJson(json);

  Map<String, dynamic> toJson() => _$CurrentWeatherModelToJson(this);
}

// Helper classes for parsing nested JSON objects
@JsonSerializable()
class _WeatherSys {
  @JsonKey(name: 'country')
  final String country;

  const _WeatherSys({required this.country});

  factory _WeatherSys.fromJson(Map<String, dynamic> json) =>
      _$WeatherSysFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherSysToJson(this);
}

@JsonSerializable()
class _WeatherMain {
  @JsonKey(name: 'temp')
  final double temp;

  @JsonKey(name: 'feels_like')
  final double feelsLike;

  @JsonKey(name: 'humidity')
  final int humidity;

  @JsonKey(name: 'pressure')
  final int pressure;

  const _WeatherMain({
    required this.temp,
    required this.feelsLike,
    required this.humidity,
    required this.pressure,
  });

  factory _WeatherMain.fromJson(Map<String, dynamic> json) =>
      _$WeatherMainFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherMainToJson(this);
}

@JsonSerializable()
class _WeatherWind {
  @JsonKey(name: 'speed')
  final double speed;

  const _WeatherWind({required this.speed});

  factory _WeatherWind.fromJson(Map<String, dynamic> json) =>
      _$WeatherWindFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherWindToJson(this);
}

@JsonSerializable()
class _WeatherCondition {
  @JsonKey(name: 'description')
  final String description;

  @JsonKey(name: 'icon')
  final String icon;

  const _WeatherCondition({required this.description, required this.icon});

  factory _WeatherCondition.fromJson(Map<String, dynamic> json) =>
      _$WeatherConditionFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherConditionToJson(this);
}
