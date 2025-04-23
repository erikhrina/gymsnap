import 'dart:typed_data';

import 'package:gymsnap/enums/exercise_level_enum.dart';

final imageCache = <String, Uint8List>{};

Uint8List? getImageFromCache(String id) {
  return imageCache[id];
}

void cacheImage(String id, Uint8List image) {
  imageCache[id] = image;
}

double mapExerciseLevelToPortion(ExerciseLevelEnum level) {
  switch (level) {
    case ExerciseLevelEnum.beginner:
      return 0.25;
    case ExerciseLevelEnum.intermediate:
      return 0.50;
    case ExerciseLevelEnum.advanced:
      return 0.75;
  }
}
