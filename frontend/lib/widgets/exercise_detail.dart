import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:gymsnap/api/images_api.dart';
import 'package:gymsnap/models/exercise.dart';
import 'package:gymsnap/utils/app_util.dart';
import 'package:gymsnap/utils/theme.dart';
import 'package:gymsnap/widgets/difficulty_line.dart';
import 'package:gymsnap/widgets/loading_indicator.dart';

class ExerciseDetailWidget extends StatelessWidget {
  const ExerciseDetailWidget(this.exercise, {super.key});

  final ExerciseDetail exercise;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 150,
            child: FutureBuilder(
              future: GetIt.instance<ImagesApiService>().getImage(
                exerciseId: exercise.id,
              ),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final data = snapshot.data;
                  return data != null && data.isNotEmpty
                      ? Image.memory(data)
                      : Image.asset(
                          'assets/images/no-image.png',
                        );
                } else if (snapshot.hasError) {
                  if (kDebugMode) print(snapshot.error);
                  return Image.asset(
                    'assets/images/no-image.png',
                  );
                } else {
                  return Center(child: LoadingIndicatorWrapper());
                }
              },
            ),
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                exercise.name,
                textAlign: TextAlign.left,
                style: AppTheme.of(context).titleLarge,
              ),
            ],
          ),
          Divider(
            thickness: 1,
            color: AppTheme.of(context).primary,
          ),
          SizedBox(
            height: 30,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8.0,
                      ),
                      child: Image.asset(
                        'assets/images/icon-muscle.png',
                      ),
                    ),
                    Text(
                      exercise.targetMuscle,
                      textAlign: TextAlign.left,
                      style: AppTheme.of(context).primaryMedium,
                    ),
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8.0,
                      ),
                      child: Image.asset(
                        'assets/images/icon-equipment.png',
                      ),
                    ),
                    Text(
                      (exercise.secondaryEquipment != null)
                          ? '${exercise.primaryEquipment}, ${exercise.secondaryEquipment}'
                          : exercise.primaryEquipment,
                      textAlign: TextAlign.left,
                      style: AppTheme.of(context).primaryMedium,
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 8),
          Text(
            exercise.description,
            textAlign: TextAlign.left,
            style: AppTheme.of(context).primarySmall,
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Difficulty',
                      textAlign: TextAlign.left,
                      style: AppTheme.of(context).primaryMedium,
                    ),
                  ],
                ),
              ),
              DifficultyLine(
                mapExerciseLevelToPortion(exercise.level),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
