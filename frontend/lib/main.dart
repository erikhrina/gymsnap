import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:gymsnap/api/api_client.dart';
import 'package:gymsnap/api/equipment_api.dart';
import 'package:gymsnap/api/exercises_api.dart';
import 'package:gymsnap/api/images_api.dart';
import 'package:gymsnap/api/muscles_api.dart';
import 'package:gymsnap/api/prediction_api.dart';
import 'package:gymsnap/pages/home/home_page.dart';

/// GetIt Instance
final getIt = GetIt.instance;

/// Registering the ApiClient and services
void setup() {
  final apiClient = ApiClient(baseUrl: '194.171.191.226:2585');
  getIt.registerSingleton<ExercisesApiService>(ExercisesApiService(apiClient));
  getIt.registerSingleton<EquipmentApiService>(EquipmentApiService(apiClient));
  getIt.registerSingleton<MusclesApiService>(MusclesApiService(apiClient));
  getIt.registerSingleton<ImagesApiService>(ImagesApiService(apiClient));
  getIt
      .registerSingleton<PredictionApiService>(PredictionApiService(apiClient));
}

void main() {
  setup(); // Initialize the dependencies
  runApp(
    MaterialApp(
      title: 'GymSnap',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
    ),
  );
}
