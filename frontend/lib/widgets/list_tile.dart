import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gymsnap/utils/theme.dart';
import 'package:gymsnap/widgets/filters_sheet.dart';
import 'package:gymsnap/widgets/loading_indicator.dart';

class ListTileWidget extends StatelessWidget {
  const ListTileWidget({
    super.key,
    required this.onTap,
    required this.getImage,
    required this.id,
    required this.primaryText,
    this.secondaryText,
    this.padding,
  });

  final void Function() onTap;
  final Future<Uint8List?> Function() getImage;
  final String id;
  final String primaryText;
  final String? secondaryText;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    bool isSelected =
        selectedEquipment?.id == id || selectedMuscleGroup?.id == id;

    return Padding(
      padding: padding ?? const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: onTap,
        splashFactory: InkRipple.splashFactory,
        borderRadius: BorderRadius.circular(8.0),
        child: Container(
          decoration: BoxDecoration(
            color:
                isSelected ? AppTheme.of(context).primary : Colors.transparent,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Row(
            children: [
              SizedBox(width: 2.0, height: 90.0),
              Container(
                height: 86,
                width: 86,
                decoration: BoxDecoration(
                  color: AppTheme.of(context).primaryBackground,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: FutureBuilder(
                  future: getImage(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final data = snapshot.data;
                      return data != null && data.isNotEmpty
                          ? Image.memory(
                              data,
                              fit: BoxFit.scaleDown,
                            )
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
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      primaryText,
                      style: AppTheme.of(context).primaryMedium.copyWith(
                            color: isSelected ? Colors.white : null,
                            fontWeight: isSelected ? FontWeight.w700 : null,
                          ),
                    ),
                    if (secondaryText != null)
                      Text(
                        secondaryText!,
                        style: AppTheme.of(context).primarySmall.copyWith(
                              color: isSelected ? Colors.white : null,
                              fontWeight: isSelected ? FontWeight.w500 : null,
                            ),
                      ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
