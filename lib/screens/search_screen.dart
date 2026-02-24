import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../config/app_constants.dart';
import '../models/weather_status.dart';
import '../providers/city_weather_provider.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CityWeatherProvider>().reset();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<CityWeatherProvider>();
    final isLoading = provider.status == WeatherStatus.loading;
    return Scaffold(
      appBar: AppBar(title: const Text("Search city")),
      body: Padding(
        padding: const EdgeInsets.all(AppConstants.spacingMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: AppConstants.spacingMd),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(AppConstants.spacingSm),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _controller,
                        textCapitalization: TextCapitalization.words,
                        textInputAction: TextInputAction.search,
                        decoration: const InputDecoration(
                          hintText: "Enter city name...",
                          prefixIcon: Icon(Icons.location_city_outlined),
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                        ),
                        onSubmitted: isLoading
                            ? null
                            : (_) => _onSearch(provider),
                      ),
                    ),
                    const SizedBox(width: AppConstants.spacingSm),
                    IconButton(
                      onPressed: isLoading ? null : () => _onSearch(provider),
                      icon: Icon(
                        isLoading ? Icons.circle_outlined : Icons.search,
                        size: AppConstants.iconSm,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: AppConstants.spacingMd),
            if (provider.status == WeatherStatus.error)
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(AppConstants.spacingMd),
                  child: Row(
                    children: [
                      Icon(
                        Icons.error_outline_rounded,
                        color: Theme.of(context).colorScheme.error,
                        size: AppConstants.iconMd,
                      ),
                      const SizedBox(width: AppConstants.spacingSm),
                      Expanded(
                        child: Text(
                          provider.errorMessage ?? "Something went wrong",
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(
                                color: Theme.of(context).colorScheme.error,
                              ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Future<void> _onSearch(CityWeatherProvider provider) async {
    final city = _controller.text.trim();
    if (city.isEmpty) return;

    FocusScope.of(context).unfocus();

    await provider.fetchCityWeather(city);
    if (!mounted) return;

    if (provider.status == WeatherStatus.loaded) {
      _controller.clear();
      Navigator.pushNamed(context, "/city-detail");
    }
  }
}
