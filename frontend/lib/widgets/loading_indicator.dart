import 'package:flutter/material.dart';
import 'package:gymsnap/utils/theme.dart';

class LoadingIndicatorWrapper extends StatelessWidget {
  const LoadingIndicatorWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      color: AppTheme.of(context).primary,
    );
  }
}
