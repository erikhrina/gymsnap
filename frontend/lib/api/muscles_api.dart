import 'dart:convert';

import 'package:gymsnap/api/api_client.dart';
import 'package:gymsnap/models/muscle_group.dart';

/// Service class to handle API calls related to muscle groups.
class MusclesApiService {
  final ApiClient apiClient;

  /// Constructor to initialize the API client.
  MusclesApiService(this.apiClient);

  /// Fetches a list of equipment
  Future<List<MuscleGroup>> getMuscleGroups() async {
    final response = await apiClient.get('getMuscleGroups');

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = jsonDecode(response.body);
      return jsonList.map((json) => MuscleGroup.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch muscle groups.');
    }
  }
}
