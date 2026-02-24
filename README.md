<div align="center">
  <img src="https://cdn-icons-png.flaticon.com/512/1163/1163624.png" alt="logo" width="100" height="auto" />
  
  <h1>
    <font style="font-weight: bold;">Flutter Weather App</font>
  </h1>

  A simple Flutter app that shows current weather and a 5‑day forecast using the OpenWeatherMap API.

  <p>
    <img alt="Frontend" src="https://img.shields.io/badge/Frontend-Flutter-blue.svg?style=for-the-badge&logo=flutter"/>
    <img alt="Weather API" src="https://img.shields.io/badge/Weather%20API-OpenWeatherMap-eb6e4b?style=for-the-badge&logo=openweathermap&logoColor=white"/>
  </p>

</div>

## Features

- **Current location weather**
- **City search**
- **5‑day forecast**
- **Pull to refresh**

## Tech Stack

- **Flutter**
- **Provider** for state management
- **http** for API requests
- **geolocator** for location

## Getting Started

### 1) Prerequisites

- Flutter SDK installed
- An **OpenWeatherMap API key**

### 2) Install dependencies

```bash
flutter pub get
```

### 3) Configure the API key

This project reads the API key from a compile-time environment variable:

- The code uses: `String.fromEnvironment('OWM_API_KEY')`
- Run the app with:

```bash
flutter run --dart-define=OWM_API_KEY=YOUR_KEY_HERE
```

If the key is missing or invalid, the app will show an error state.

## Running

### Android emulator

```bash
flutter run --dart-define=OWM_API_KEY=YOUR_KEY_HERE
```

### Windows

```bash
flutter run -d windows --dart-define=OWM_API_KEY=YOUR_KEY_HERE
```

## Troubleshooting

### Stuck on “Loading…” on Android emulator

The Android emulator may not provide a location fix by default.

- Open **Emulator → Extended controls (… ) → Location**
- Set a test location (map or coordinates)
- Ensure **Android Settings → Location** is enabled

### API request issues

- Verify your API key is correct
- Confirm the device/emulator has internet access
- Make sure you’re launching with `--dart-define=OWM_API_KEY=...`
