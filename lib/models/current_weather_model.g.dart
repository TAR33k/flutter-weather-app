// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'current_weather_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CurrentWeatherModel _$CurrentWeatherModelFromJson(Map<String, dynamic> json) =>
    CurrentWeatherModel(
      cityName: json['name'] as String,
      sys: _WeatherSys.fromJson(json['sys'] as Map<String, dynamic>),
      main: _WeatherMain.fromJson(json['main'] as Map<String, dynamic>),
      wind: _WeatherWind.fromJson(json['wind'] as Map<String, dynamic>),
      weatherConditions: (json['weather'] as List<dynamic>)
          .map((e) => _WeatherCondition.fromJson(e as Map<String, dynamic>))
          .toList(),
      visibility: (json['visibility'] as num).toInt(),
    );

Map<String, dynamic> _$CurrentWeatherModelToJson(
  CurrentWeatherModel instance,
) => <String, dynamic>{
  'name': instance.cityName,
  'sys': instance.sys,
  'main': instance.main,
  'wind': instance.wind,
  'weather': instance.weatherConditions,
  'visibility': instance.visibility,
};

_WeatherSys _$WeatherSysFromJson(Map<String, dynamic> json) =>
    _WeatherSys(country: json['country'] as String);

Map<String, dynamic> _$WeatherSysToJson(_WeatherSys instance) =>
    <String, dynamic>{'country': instance.country};

_WeatherMain _$WeatherMainFromJson(Map<String, dynamic> json) => _WeatherMain(
  temp: (json['temp'] as num).toDouble(),
  feelsLike: (json['feels_like'] as num).toDouble(),
  humidity: (json['humidity'] as num).toInt(),
  pressure: (json['pressure'] as num).toInt(),
);

Map<String, dynamic> _$WeatherMainToJson(_WeatherMain instance) =>
    <String, dynamic>{
      'temp': instance.temp,
      'feels_like': instance.feelsLike,
      'humidity': instance.humidity,
      'pressure': instance.pressure,
    };

_WeatherWind _$WeatherWindFromJson(Map<String, dynamic> json) =>
    _WeatherWind(speed: (json['speed'] as num).toDouble());

Map<String, dynamic> _$WeatherWindToJson(_WeatherWind instance) =>
    <String, dynamic>{'speed': instance.speed};

_WeatherCondition _$WeatherConditionFromJson(Map<String, dynamic> json) =>
    _WeatherCondition(
      description: json['description'] as String,
      icon: json['icon'] as String,
    );

Map<String, dynamic> _$WeatherConditionToJson(_WeatherCondition instance) =>
    <String, dynamic>{
      'description': instance.description,
      'icon': instance.icon,
    };
