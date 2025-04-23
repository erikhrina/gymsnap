import 'package:flutter/material.dart';
import 'package:gymsnap/utils/theme.dart';

class DialogWidget extends StatelessWidget {
  final String? title;
  final String? message;
  final Color? color;
  final double? height;
  final Widget? child;

  const DialogWidget({
    this.title,
    this.message,
    this.color,
    this.height,
    this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.zero,
      backgroundColor: Colors.transparent,
      alignment: const AlignmentDirectional(0, 0).resolve(
        Directionality.of(context),
      ),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: InkWell(
            splashColor: Colors.transparent,
            focusColor: Colors.transparent,
            hoverColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              height: height ?? 150,
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppTheme.of(context).primaryBackground,
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: Stack(
                children: [
                  Align(
                    alignment: const Alignment(1, -1),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Icon(
                        Icons.close,
                        size: 24,
                        color: color ?? AppTheme.of(context).primary,
                      ),
                    ),
                  ),
                  child != null
                      ? child!
                      : Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              if (title != null)
                                Padding(
                                  padding: const EdgeInsets.all(6.0),
                                  child: Text(
                                    title!,
                                    textAlign: TextAlign.center,
                                    style: AppTheme.of(context)
                                        .titleLarge
                                        .copyWith(color: color),
                                  ),
                                ),
                              if (message != null)
                                Padding(
                                  padding:
                                      const EdgeInsetsDirectional.symmetric(
                                    horizontal: 4.0,
                                  ),
                                  child: Text(
                                    message!,
                                    textAlign: TextAlign.center,
                                    style: AppTheme.of(context).primaryMedium,
                                  ),
                                ),
                            ],
                          ),
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
