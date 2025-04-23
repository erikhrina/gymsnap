import 'package:flutter/material.dart';
import 'package:gymsnap/utils/theme.dart';

class FilterChipWrapper extends StatelessWidget {
  final String label;
  final void Function() onTap;

  const FilterChipWrapper({
    required this.label,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      label: Text(
        label,
        style: AppTheme.of(context).primaryMedium.copyWith(
              color: Colors.white,
            ),
      ),
      selected: true,
      selectedColor: AppTheme.of(context).primary,
      showCheckmark: false,
      deleteIcon: Icon(
        Icons.close,
        color: Colors.white,
      ),
      onDeleted: onTap,
      onSelected: (_) => onTap(),
    );
  }
}
