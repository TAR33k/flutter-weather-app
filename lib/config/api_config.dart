class ApiConfig {
  const ApiConfig._();

  static const String apiKey = String.fromEnvironment('OWM_API_KEY');
  static const String baseUrl = 'https://api.openweathermap.org/data/2.5';

  String iconUrl(String iconCode) {
    return 'https://openweathermap.org/img/wn/$iconCode@2x.png';
  }
}
