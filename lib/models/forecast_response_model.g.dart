// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'forecast_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ForecastResponseModel _$ForecastResponseModelFromJson(
  Map<String, dynamic> json,
) => ForecastResponseModel(
  list: (json['list'] as List<dynamic>)
      .map((e) => ForecastEntryModel.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$ForecastResponseModelToJson(
  ForecastResponseModel instance,
) => <String, dynamic>{'list': instance.list};

ForecastEntryModel _$ForecastEntryModelFromJson(Map<String, dynamic> json) =>
    ForecastEntryModel(
      dtTxt: json['dt_txt'] as String,
      main: _ForecastEntryMain.fromJson(json['main'] as Map<String, dynamic>),
      weather: (json['weather'] as List<dynamic>)
          .map(
            (e) => _ForecastEntryCondition.fromJson(e as Map<String, dynamic>),
          )
          .toList(),
    );

Map<String, dynamic> _$ForecastEntryModelToJson(ForecastEntryModel instance) =>
    <String, dynamic>{
      'dt_txt': instance.dtTxt,
      'main': instance.main,
      'weather': instance.weather,
    };

_ForecastEntryMain _$ForecastEntryMainFromJson(Map<String, dynamic> json) =>
    _ForecastEntryMain(
      temp: (json['temp'] as num).toDouble(),
      tempMin: (json['temp_min'] as num).toDouble(),
      tempMax: (json['temp_max'] as num).toDouble(),
    );

Map<String, dynamic> _$ForecastEntryMainToJson(_ForecastEntryMain instance) =>
    <String, dynamic>{
      'temp': instance.temp,
      'temp_min': instance.tempMin,
      'temp_max': instance.tempMax,
    };

_ForecastEntryCondition _$ForecastEntryConditionFromJson(
  Map<String, dynamic> json,
) => _ForecastEntryCondition(
  description: json['description'] as String,
  icon: json['icon'] as String,
);

Map<String, dynamic> _$ForecastEntryConditionToJson(
  _ForecastEntryCondition instance,
) => <String, dynamic>{
  'description': instance.description,
  'icon': instance.icon,
};
