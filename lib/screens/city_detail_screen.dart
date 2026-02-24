import 'package:flutter/material.dart';

class CityDetailScreen extends StatelessWidget {
  const CityDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('City Detail')),
      body: const Center(child: Text('City Details')),
    );
  }
}
