import 'dart:typed_data';

import 'package:gymsnap/api/api_client.dart';
import 'package:gymsnap/utils/app_util.dart';

/// Service class to handle API calls related to images.
class ImagesApiService {
  final ApiClient apiClient;

  /// Constructor to initialize the API client.
  ImagesApiService(this.apiClient);

  /// Fetches an image based on an exerciseId, muscleId, or equipmentId.
  Future<Uint8List?> getImage({
    String? exerciseId,
    String? muscleId,
    String? equipmentId,
    int retryCount = 2,
  }) async {
    Uint8List? cachedImage;

    final headers = {
      "Connection": "Keep-Alive",
    };

    final queryParameters = <String, String>{};
    if (exerciseId != null) {
      queryParameters['exercise_id'] = exerciseId;
      cachedImage = getImageFromCache(exerciseId);
    } else if (muscleId != null) {
      cachedImage = getImageFromCache(muscleId);
      queryParameters['muscle_id'] = muscleId;
    } else if (equipmentId != null) {
      cachedImage = getImageFromCache(equipmentId);
      queryParameters['equipment_id'] = equipmentId;
    } else {
      throw Exception('No ID provided.');
    }

    if (cachedImage != null) return cachedImage;

    final response = await apiClient.get(
      'getImage',
      headers: headers,
      queryParameters: queryParameters,
    );

    if (response.statusCode == 200) {
      return response.bodyBytes;
    } else if (retryCount > 0) {
      return await getImage(
        exerciseId: exerciseId,
        muscleId: muscleId,
        equipmentId: equipmentId,
        retryCount: --retryCount,
      );
    } else {
      throw Exception('Failed to fetch image.');
    }
  }
}
