import 'package:flutter/material.dart';
import 'package:gymsnap/utils/theme.dart';
import 'package:gymsnap/widgets/dialog_widget.dart';

/// Service class to display toasts
class ToastsService {
  /// Display a dialog.
  static Future<void> showDialogWidget(
    BuildContext context, {
    Widget? widget,
    String? title,
    String? message,
    Color? color,
    double? height,
  }) async {
    await showDialog(
      context: context,
      builder: (dialogContext) => DialogWidget(
        title: title,
        message: message,
        color: color,
        height: height,
        child: widget,
      ),
    );
  }

  /// Display a snackbar.
  static Future<void> showSnackbar(
    BuildContext context, {
    required String message,
    Duration duration = const Duration(milliseconds: 2000),
  }) async {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: AppTheme.of(context).secondaryBackground,
        elevation: 0,
        padding: EdgeInsets.zero,
        behavior: SnackBarBehavior.floating,
        content: Theme(
          data: ThemeData(snackBarTheme: const SnackBarThemeData()),
          child: DialogWidget(
            title: message,
            color: AppTheme.of(context).primary,
          ),
        ),
        duration: duration,
      ),
    );
  }
}
