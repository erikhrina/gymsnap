import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:gymsnap/api/images_api.dart';
import 'package:gymsnap/models/equipment.dart';
import 'package:gymsnap/models/exercise.dart';
import 'package:gymsnap/models/muscle_group.dart';
import 'package:gymsnap/utils/app_util.dart';
import 'package:gymsnap/utils/theme.dart';
import 'package:gymsnap/widgets/keep_alive_wrapper.dart';
import 'package:gymsnap/widgets/list_tile.dart';
import 'package:gymsnap/widgets/loading_indicator.dart';

class GenericList extends StatefulWidget {
  final Future<dynamic> fetchData;
  final void Function(dynamic) onTap;
  final bool enableRefresh;
  final void Function()? notifyParent;

  const GenericList(
    this.fetchData, {
    required this.onTap,
    this.enableRefresh = false,
    this.notifyParent,
    super.key,
  });

  @override
  State<GenericList> createState() => _GenericListState();
}

class _GenericListState extends State<GenericList> {
  @override
  Widget build(BuildContext context) {
    return KeepAliveWidgetWrapper(
      builder: (context) => FutureBuilder(
        future: widget.fetchData,
        builder: (context, snapshot) {
          return widget.enableRefresh
              ? RefreshIndicator(
                  color: AppTheme.of(context).primary,
                  backgroundColor: AppTheme.of(context).secondaryBackground,
                  elevation: 0,
                  onRefresh: () async {
                    if (widget.notifyParent != null) {
                      widget.notifyParent!();
                    }
                  },
                  child: buildListView(snapshot, context),
                )
              : buildListView(snapshot, context);
        },
      ),
    );
  }

  Widget buildListView(AsyncSnapshot<dynamic> snapshot, BuildContext context) {
    if (snapshot.hasData) {
      final data = snapshot.data;
      return data.isNotEmpty
          ? ListView(
              padding: EdgeInsets.zero,
              addAutomaticKeepAlives: true,
              children: List.generate(
                data.length,
                (index) => KeepAliveWidgetWrapper(
                  builder: (context) => ListTileWidget(
                    onTap: () => widget.onTap(data[index]),
                    getImage: () async => _getImage(data[index]),
                    id: data[index].id,
                    primaryText: data[index].name,
                    secondaryText: data[index] is ExerciseSummary
                        ? data[index].targetMuscle
                        : null,
                    padding: const EdgeInsets.symmetric(
                      vertical: 4.0,
                    ),
                  ),
                ),
              ),
            )
          : _NoDataPlaceholder();
    } else if (snapshot.hasError) {
      if (kDebugMode) print(snapshot.error);
      return _NoDataPlaceholder();
    } else {
      return Center(child: LoadingIndicatorWrapper());
    }
  }

  Future<Uint8List?> _getImage(object) async {
    Uint8List? image;
    try {
      if (object is ExerciseSummary) {
        image = await GetIt.instance<ImagesApiService>().getImage(
          exerciseId: object.id,
        );
      } else if (object is Equipment) {
        image = await GetIt.instance<ImagesApiService>().getImage(
          equipmentId: object.id,
        );
      } else if (object is MuscleGroup) {
        image = await GetIt.instance<ImagesApiService>().getImage(
          muscleId: object.id,
        );
      }

      if (image != null) cacheImage(object.id, image);
      return image;
    } catch (e) {
      return null;
    }
  }
}

class _NoDataPlaceholder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: AlwaysScrollableScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          'No data avaliable.',
          style: AppTheme.of(context).labelLarge,
        ),
      ),
    );
  }
}
