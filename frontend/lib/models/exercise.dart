import 'package:gymsnap/enums/exercise_level_enum.dart';

/// Minimal model for list view
class ExerciseSummary {
  final String id;
  final String name;
  final String targetMuscle;

  ExerciseSummary({
    required this.id,
    required this.name,
    required this.targetMuscle,
  });

  factory ExerciseSummary.fromJson(Map<String, dynamic> json) {
    return ExerciseSummary(
      id: json['id'],
      name: json['name'],
      targetMuscle: json['muscle_group'],
    );
  }
}

/// Detailed model for individual view
class ExerciseDetail {
  final String id;
  final String name;
  final String targetMuscle;
  final String description;
  final String primaryEquipment;
  final ExerciseLevelEnum level;
  final String? secondaryEquipment;
  final List<String>? secondaryMuscles;

  ExerciseDetail({
    required this.id,
    required this.name,
    required this.description,
    required this.primaryEquipment,
    required this.targetMuscle,
    required this.level,
    this.secondaryEquipment,
    this.secondaryMuscles,
  });

  factory ExerciseDetail.fromJson(Map<String, dynamic> json) {
    ExerciseLevelEnum mapStringToExerciseLevel(String level) {
      switch (level.toLowerCase()) {
        case 'beginner':
          return ExerciseLevelEnum.beginner;
        case 'intermediate':
          return ExerciseLevelEnum.intermediate;
        case 'advanced':
          return ExerciseLevelEnum.advanced;
        default:
          return ExerciseLevelEnum.intermediate;
      }
    }

    return ExerciseDetail(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      primaryEquipment: json['primary_equipment'],
      targetMuscle: json['target_muscle'],
      level: mapStringToExerciseLevel(json['level']),
      secondaryEquipment: json['secondary_equipment'],
      secondaryMuscles: (json['secondary_muscles'] as List?)?.cast<String>(),
    );
  }
}
