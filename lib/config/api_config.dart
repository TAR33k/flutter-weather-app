class ApiConfig {
  const ApiConfig._();

  static const String apiKey = String.fromEnvironment('OWM_API_KEY');
  static const String _baseUrl = 'https://api.openweathermap.org/data/2.5';

  static String currentWeatherByCoords(double lat, double lon) {
    return '$_baseUrl/weather?lat=$lat&lon=$lon&appid=$apiKey&units=metric';
  }

  static String currentWeatherByCity(String city) {
    return '$_baseUrl/weather?q=${Uri.encodeComponent(city)}&appid=$apiKey&units=metric';
  }

  static String forecastByCoords(double lat, double lon) {
    return '$_baseUrl/forecast?lat=$lat&lon=$lon&appid=$apiKey&units=metric';
  }

  static String forecastByCity(String city) {
    return '$_baseUrl/forecast?q=${Uri.encodeComponent(city)}&appid=$apiKey&units=metric';
  }

  static String iconUrl(String iconCode) {
    return 'https://openweathermap.org/img/wn/$iconCode@2x.png';
  }
}
