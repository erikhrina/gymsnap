import 'package:flutter/material.dart';
import 'package:gymsnap/services/toast_service.dart';

/// Service class to handle exceptions
class ExceptionService {
  static handleException(
    BuildContext context,
    Exception e,
  ) {
    ToastsService.showDialogWidget(
      context,
      title: 'Error',
      message: e.toString(),
      color: Colors.red[700],
    );
  }
}
