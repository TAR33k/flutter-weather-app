// ignore_for_file: library_private_types_in_public_api

import 'package:json_annotation/json_annotation.dart';

part 'forecast_response_model.g.dart';

@JsonSerializable()
class ForecastResponseModel {
  @JsonKey(name: 'list')
  final List<ForecastEntryModel> list;

  const ForecastResponseModel({required this.list});

  factory ForecastResponseModel.fromJson(Map<String, dynamic> json) =>
      _$ForecastResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$ForecastResponseModelToJson(this);
}

@JsonSerializable()
class ForecastEntryModel {
  @JsonKey(name: 'dt_txt')
  final String dtTxt;

  @JsonKey(name: 'main')
  final _ForecastEntryMain main;

  @JsonKey(name: 'weather')
  final List<_ForecastEntryCondition> weather;

  const ForecastEntryModel({
    required this.dtTxt,
    required this.main,
    required this.weather,
  });

  // Convenience getters
  double get temp => main.temp;
  double get tempMin => main.tempMin;
  double get tempMax => main.tempMax;
  String get description => weather.isNotEmpty ? weather.first.description : '';
  String get iconCode => weather.isNotEmpty ? weather.first.icon : '';
  bool get isMidday => dtTxt.endsWith('12:00:00');
  String get dateKey => dtTxt.substring(0, 10);

  factory ForecastEntryModel.fromJson(Map<String, dynamic> json) =>
      _$ForecastEntryModelFromJson(json);

  Map<String, dynamic> toJson() => _$ForecastEntryModelToJson(this);
}

// Helper classes for parsing nested JSON objects
@JsonSerializable()
class _ForecastEntryMain {
  @JsonKey(name: 'temp')
  final double temp;

  @JsonKey(name: 'temp_min')
  final double tempMin;

  @JsonKey(name: 'temp_max')
  final double tempMax;

  const _ForecastEntryMain({
    required this.temp,
    required this.tempMin,
    required this.tempMax,
  });

  factory _ForecastEntryMain.fromJson(Map<String, dynamic> json) =>
      _$ForecastEntryMainFromJson(json);

  Map<String, dynamic> toJson() => _$ForecastEntryMainToJson(this);
}

@JsonSerializable()
class _ForecastEntryCondition {
  @JsonKey(name: 'description')
  final String description;

  @JsonKey(name: 'icon')
  final String icon;

  const _ForecastEntryCondition({
    required this.description,
    required this.icon,
  });

  factory _ForecastEntryCondition.fromJson(Map<String, dynamic> json) =>
      _$ForecastEntryConditionFromJson(json);

  Map<String, dynamic> toJson() => _$ForecastEntryConditionToJson(this);
}
