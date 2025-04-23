import 'dart:convert';

import 'package:gymsnap/api/api_client.dart';
import 'package:gymsnap/models/equipment.dart';

/// Service class to handle API calls related to equipment.
class EquipmentApiService {
  final ApiClient apiClient;

  /// Constructor to initialize the API client.
  EquipmentApiService(this.apiClient);

  /// Fetches a list of equipment.
  Future<List<Equipment>> getEquipment() async {
    final response = await apiClient.get('getEquipment');

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = jsonDecode(response.body);
      return jsonList.map((json) => Equipment.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch equipment.');
    }
  }
}
