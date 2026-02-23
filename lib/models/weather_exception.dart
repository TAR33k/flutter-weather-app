class WeatherException implements Exception {
  const WeatherException(this.message);
  final String message;
}

class CityNotFoundException extends WeatherException {
  const CityNotFoundException(String city)
    : super('City "$city" was not found. Please check the spelling.');
}

class ApiKeyException extends WeatherException {
  const ApiKeyException()
    : super('Weather service is unavailable. Invalid API key.');
}

class WeatherApiException extends WeatherException {
  const WeatherApiException(int statusCode)
    : super('Weather service returned an unexpected error ($statusCode).');
}

class NetworkException extends WeatherException {
  const NetworkException()
    : super('No internet connection. Please check your network and try again.');
}

class LocationServiceDisabledException extends WeatherException {
  const LocationServiceDisabledException()
    : super(
        'Location services are disabled. Please enable them in your device settings.',
      );
}

class LocationPermissionDeniedException extends WeatherException {
  const LocationPermissionDeniedException()
    : super(
        'Location permission was denied. Please allow location access to see local weather.',
      );
}

class LocationPermissionPermanentlyDeniedException extends WeatherException {
  const LocationPermissionPermanentlyDeniedException()
    : super(
        'Location permission is permanently denied. Please enable it in your device settings.',
      );
}
