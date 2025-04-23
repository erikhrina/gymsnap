import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:http_parser/http_parser.dart';
import 'package:http/http.dart' as http;
import 'package:gymsnap/api/api_client.dart';
import 'package:gymsnap/models/equipment.dart';

/// Service class to handle API calls related to predictions.
class PredictionApiService {
  final ApiClient apiClient;

  /// Constructor to initialize the API client.
  PredictionApiService(this.apiClient);

  /// Retrieves an equipment based on model's classification of the provided image.
  Future<Equipment?> getPrediction(Uint8List image) async {
    final uri = Uri.http(apiClient.baseUrl, 'predict');

    final request = http.MultipartRequest('POST', uri)
      ..headers['Content-Type'] = 'multipart/form-data'
      ..files.add(http.MultipartFile.fromBytes(
        'image',
        image.toList(),
        filename: 'photo.jpg',
        contentType: MediaType(
          'image',
          'jpg',
        ),
      ));

    // Send the request and get the response
    final response = await request.send();
    final responseBody = await response.stream.bytesToString();

    if (response.statusCode == 200) {
      final json = jsonDecode(responseBody);
      return Equipment.fromJson(json);
    } else {
      debugPrint(responseBody);
      throw Exception('Failed to fetch prediction.');
    }
  }
}
