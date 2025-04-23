import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:gymsnap/api/exercises_api.dart';
import 'package:gymsnap/models/exercise.dart';
import 'package:gymsnap/pages/camera/camera_page.dart';
import 'package:gymsnap/services/exception_service.dart';
import 'package:gymsnap/services/toast_service.dart';
import 'package:gymsnap/utils/theme.dart';
import 'package:gymsnap/widgets/exercise_detail.dart';
import 'package:gymsnap/widgets/filter_chip.dart';
import 'package:gymsnap/widgets/generic_list.dart';
import 'package:gymsnap/widgets/filters_sheet.dart';
import 'package:gymsnap/widgets/icon_button.dart';
import 'package:gymsnap/widgets/search_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _exercisesApiService = GetIt.instance<ExercisesApiService>();
  late TextEditingController _searchTextController;

  @override
  void initState() {
    _searchTextController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.of(context).primaryBackground,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 16.0,
              horizontal: 16.0,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: IconButtonWrapper(
                        icon: Icons.filter_alt_outlined,
                        padding: const EdgeInsets.symmetric(
                          vertical: 4.0,
                          horizontal: 8.0,
                        ),
                        onPressed: () async {
                          await showModalBottomSheet(
                            context: context,
                            useSafeArea: true,
                            isScrollControlled: true,
                            enableDrag: false,
                            showDragHandle: false,
                            backgroundColor: Colors.transparent,
                            builder: (context) {
                              return FiltersSheet(
                                () => setState(() {
                                  Navigator.pop(context);
                                }),
                              );
                            },
                          );
                        },
                      ),
                    ),
                    Expanded(
                      child: IconButtonWrapper(
                        icon: Icons.camera_alt_outlined,
                        padding: const EdgeInsets.symmetric(
                          vertical: 4.0,
                          horizontal: 8.0,
                        ),
                        onPressed: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const CameraPage(),
                            ),
                          );
                          setState(() {});
                        },
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 8.0,
                  ),
                  child: SearchWidget(
                    controller: _searchTextController,
                    onSubmit: () => setState(() {}),
                  ),
                ),
                SizedBox(
                  height:
                      selectedEquipment != null || selectedMuscleGroup != null
                          ? 45
                          : 0,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      if (selectedEquipment != null)
                        Padding(
                          padding: const EdgeInsets.only(right: 4.0),
                          child: FilterChipWrapper(
                            label: selectedEquipment!.name,
                            onTap: () => setState(() {
                              selectedEquipment = null;
                            }),
                          ),
                        ),
                      if (selectedMuscleGroup != null)
                        FilterChipWrapper(
                          label: selectedMuscleGroup!.name,
                          onTap: () => setState(() {
                            selectedMuscleGroup = null;
                          }),
                        ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Recent',
                      style: AppTheme.of(context).titleMedium,
                    ),
                    Divider(
                      color: AppTheme.of(context).primary,
                      thickness: 1.0,
                    )
                  ],
                ),
                Expanded(
                  child: GenericList(
                    _exercisesApiService.getExercises(
                      searchText: _searchTextController.text.isNotEmpty
                          ? _searchTextController.text
                          : null,
                      equipmentId: selectedEquipment?.id,
                      targetMuscleId: selectedMuscleGroup?.id,
                    ),
                    enableRefresh: true,
                    notifyParent: () => setState(() {}),
                    onTap: (exercise) async {
                      try {
                        ExerciseDetail exerciseDetail =
                            await _exercisesApiService.getExerciseInfo(
                          exerciseId: exercise.id,
                        );
                        if (context.mounted) {
                          ToastsService.showDialogWidget(
                            context,
                            height: 450,
                            widget: ExerciseDetailWidget(exerciseDetail),
                          );
                        }
                      } catch (e) {
                        if (context.mounted) {
                          ExceptionService.handleException(
                            context,
                            e as Exception,
                          );
                        }
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
