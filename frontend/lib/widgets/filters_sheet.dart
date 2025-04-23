import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:gymsnap/api/equipment_api.dart';
import 'package:gymsnap/api/muscles_api.dart';
import 'package:gymsnap/models/equipment.dart';
import 'package:gymsnap/models/muscle_group.dart';
import 'package:gymsnap/utils/theme.dart';
import 'package:gymsnap/widgets/bottom_sheet.dart';
import 'package:gymsnap/widgets/generic_list.dart';

Equipment? selectedEquipment;
MuscleGroup? selectedMuscleGroup;

class FiltersSheet extends StatefulWidget {
  final void Function() onSelect;

  const FiltersSheet(this.onSelect, {super.key});

  @override
  State<FiltersSheet> createState() => _FiltersSheetState();
}

class _FiltersSheetState extends State<FiltersSheet>
    with TickerProviderStateMixin {
  final equipmentApiService = GetIt.instance<EquipmentApiService>();
  final musclesApiService = GetIt.instance<MusclesApiService>();
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(
      length: 2,
      vsync: this,
    );
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BottomSheetWrapper(builder: (context) {
      return Column(
        children: [
          TabBar(
            controller: _tabController,
            labelPadding: EdgeInsets.zero,
            isScrollable: false,
            indicatorColor: Colors.transparent,
            dividerColor: AppTheme.of(context).tertiary,
            labelStyle: AppTheme.of(context).titleLarge,
            labelColor: AppTheme.of(context).primary,
            unselectedLabelColor: AppTheme.of(context).tertiary,
            unselectedLabelStyle: AppTheme.of(context).titleMedium,
            splashBorderRadius: BorderRadius.circular(4.0),
            splashFactory: NoSplash.splashFactory,
            tabs: [
              Tab(
                text: 'Equipment',
              ),
              Tab(
                text: 'Muscles',
              ),
            ],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
              ),
              child: TabBarView(
                controller: _tabController,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  GenericList(
                    equipmentApiService.getEquipment(),
                    onTap: (dynamic model) {
                      selectedEquipment =
                          selectedEquipment?.id == model.id ? null : model;
                      widget.onSelect();
                    },
                  ),
                  GenericList(
                    musclesApiService.getMuscleGroups(),
                    onTap: (dynamic model) {
                      selectedMuscleGroup =
                          selectedMuscleGroup?.id == model.id ? null : model;
                      widget.onSelect();
                    },
                  )
                ],
              ),
            ),
          )
        ],
      );
    });
  }
}
