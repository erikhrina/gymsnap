import 'dart:convert';

import 'package:gymsnap/api/api_client.dart';
import 'package:gymsnap/models/exercise.dart';

/// Service class to handle API calls related to exercises.
class ExercisesApiService {
  final ApiClient apiClient;

  /// Constructor to initialize the API client.
  ExercisesApiService(this.apiClient);

  /// Fetches a list of exercises based on optional filters like search text,
  /// equipment ID, or target muscle ID.
  Future<List<ExerciseSummary>> getExercises({
    String? searchText,
    String? equipmentId,
    String? targetMuscleId,
  }) async {
    final queryParameters = <String, String>{};
    if (searchText != null) queryParameters['search_text'] = searchText;
    if (equipmentId != null) queryParameters['equipment_id'] = equipmentId;
    if (targetMuscleId != null) queryParameters['muscle_id'] = targetMuscleId;

    final response = await apiClient.get(
      'getExercises',
      queryParameters: queryParameters.isNotEmpty ? queryParameters : null,
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = jsonDecode(response.body);
      return jsonList.map((json) => ExerciseSummary.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch exercises.');
    }
  }

  /// Fetches detailed information about a specific exercise by its ID.
  Future<ExerciseDetail> getExerciseInfo({required String exerciseId}) async {
    final queryParameters = {'exercise_id': exerciseId};

    final response = await apiClient.get(
      'getExerciseInfo',
      queryParameters: queryParameters,
    );

    if (response.statusCode == 200) {
      final exercise = jsonDecode(response.body);
      return ExerciseDetail.fromJson(exercise);
    } else {
      throw Exception('Failed to fetch exercise details.');
    }
  }
}
