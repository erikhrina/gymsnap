import 'package:flutter/material.dart';
import 'package:gymsnap/utils/theme.dart';

class IconButtonWrapper extends StatelessWidget {
  const IconButtonWrapper({
    super.key,
    required this.onPressed,
    required this.icon,
    this.backgroundColor,
    this.iconColor,
    this.height,
    this.width,
    this.padding,
  });

  final IconData icon;
  final void Function() onPressed;
  final Color? backgroundColor;
  final Color? iconColor;
  final double? height;
  final double? width;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.all(4.0),
      child: SizedBox(
        height: height,
        width: width,
        child: IconButton(
          alignment: Alignment.center,
          style: ButtonStyle(
            shape: WidgetStateProperty.resolveWith<OutlinedBorder>(
              (states) {
                return RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                  side: BorderSide(
                    color: Colors.transparent,
                    width: 0,
                  ),
                );
              },
            ),
            iconColor: WidgetStateProperty.resolveWith<Color?>(
              (states) => Colors.white,
            ),
            backgroundColor: WidgetStateProperty.resolveWith<Color?>(
              (states) => backgroundColor ?? AppTheme.of(context).primary,
            ),
          ),
          icon: Icon(
            icon,
            color: iconColor ?? AppTheme.of(context).primaryBackground,
            size: 30,
          ),
          onPressed: onPressed,
        ),
      ),
    );
  }
}
