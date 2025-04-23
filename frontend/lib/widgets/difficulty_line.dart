import 'package:flutter/material.dart';
import 'package:gymsnap/utils/theme.dart';

class DifficultyLine extends StatelessWidget {
  final double portion;
  final double width = 300;

  const DifficultyLine(this.portion, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
          children: [
            SizedBox(height: 10),
            Container(
              height: 2.5,
              width: width,
              color: AppTheme.of(context).tertiary,
            ),
            Positioned(
              left: 0,
              child: Container(
                width: width * portion.clamp(0.0, 1.0),
                height: 2.5,
                color: AppTheme.of(context).primary,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
