import 'package:flutter/material.dart';
import 'package:lumberkit/lumberkit.dart';
import 'package:lumberkit/src/widgets/lumber_picker_stack.dart';

class LumberFuturePopPicker extends StatelessWidget {
  final Widget Function(BuildContext, Function(), Function()) builder;
  final Future<List<LumberPopOption>> optionsFuture;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final Color? selectedForegroundColor;
  final Color? selectedBackgroundColor;
  final bool scrolling;
  final double popUpHeight;
  final double popUpWidth;
  final TextAlign? textAlign;
  final List<LumberPopOption>? additionalOptions;

  LumberFuturePopPicker({
    Key? key,
    required this.builder,
    required this.optionsFuture,
    this.backgroundColor,
    this.foregroundColor,
    this.selectedForegroundColor,
    this.selectedBackgroundColor,
    this.scrolling = false,
    this.popUpHeight = 300,
    this.popUpWidth = 150,
    this.textAlign,
    this.additionalOptions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LumberPopButton(
      popUpColor: backgroundColor ?? Colors.grey[700],
      borderRadius: 8,
      childBuilder: builder,
      popUpWidth: this.popUpWidth,
      popUpHeight: this.popUpHeight,
      popUpBuilder: (context, onDismiss) {
        return FutureBuilder(
          future: optionsFuture,
          builder: (context, AsyncSnapshot<List<LumberPopOption>> snap) {
            if (snap.data == null)
              return Container(
                child: Center(
                  child: SizedBox.shrink(),
                ),
              );
            List<LumberPopOption> options = snap.data!;
            options.sort((a, b) => a.index.compareTo(b.index));
            if (additionalOptions != null) {
              options.insertAll(0, additionalOptions!);
            }
            return LumberPickerStack(
              foregroundColor: foregroundColor,
              selectedForegroundColor: selectedForegroundColor,
              selectedBackgroundColor: selectedBackgroundColor,
              scrolling: scrolling,
              textAlign: textAlign,
              onSelect: (option) {
                option.onSelect?.call();
                onDismiss();
              },
              options: options,
            );
          },
        );
      },
    );
  }
}
