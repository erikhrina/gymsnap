import 'package:flutter/material.dart';
import 'package:gymsnap/utils/theme.dart';

class BottomSheetWrapper extends StatefulWidget {
  const BottomSheetWrapper({
    super.key,
    required this.builder,
    this.onClosing,
  });

  final Widget Function(BuildContext) builder;
  final void Function()? onClosing;

  @override
  State<BottomSheetWrapper> createState() => _BottomSheetWrapperState();
}

class _BottomSheetWrapperState extends State<BottomSheetWrapper>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.viewInsetsOf(context),
      child: SizedBox(
        height: MediaQuery.sizeOf(context).height * 0.8,
        child: BottomSheet(
          animationController: _animationController,
          enableDrag: true,
          showDragHandle: true,
          dragHandleSize: Size(128, 4),
          dragHandleColor: AppTheme.of(context).tertiary,
          backgroundColor: AppTheme.of(context).secondaryBackground,
          elevation: 0,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8.0))),
          onClosing: widget.onClosing ?? () {},
          builder: widget.builder,
        ),
      ),
    );
  }
}
