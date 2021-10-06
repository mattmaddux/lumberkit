import 'package:flutter/material.dart';

import 'package:lumberkit/lumberkit.dart';
import 'package:lumberkit/src/widgets/lumber_picker_stack.dart';

class LumberPopOption {
  final int index;
  final LumberIconData? icon;
  final String? title;
  final Function() onSelect;

  LumberPopOption({
    required this.index,
    this.icon,
    this.title,
    required this.onSelect,
  });
}

class LumberPopPicker extends StatelessWidget {
  final Widget Function(BuildContext, Function(), Function()) builder;
  final List<LumberPopOption> options;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final Color? selectedForegroundColor;
  final Color? selectedBackgroundColor;
  final bool scrolling;
  final double? popUpHeight;
  final double popUpWidth;
  final TextAlign? textAlign;

  LumberPopPicker({
    Key? key,
    required this.builder,
    required this.options,
    this.backgroundColor,
    this.foregroundColor,
    this.selectedForegroundColor,
    this.selectedBackgroundColor,
    this.scrolling = false,
    this.popUpHeight,
    this.popUpWidth = 150,
    this.textAlign,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<LumberPopOption> options = this.options;
    options.sort((a, b) => a.index.compareTo(b.index));
    return LumberPopButton(
      popUpColor: backgroundColor ?? Colors.grey[700],
      borderRadius: 8,
      childBuilder: builder,
      popUpWidth: this.popUpWidth,
      popUpHeight: this.popUpHeight,
      popUpBuilder: (context, onDismiss) {
        return LumberPickerStack(
          foregroundColor: foregroundColor,
          selectedForegroundColor: selectedForegroundColor,
          selectedBackgroundColor: selectedBackgroundColor,
          scrolling: scrolling,
          textAlign: textAlign,
          onSelect: (option) {
            option.onSelect();
            onDismiss();
          },
          options: options,
        );
      },
    );
  }
}
