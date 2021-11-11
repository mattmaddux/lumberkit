import 'package:flutter/material.dart';

import 'package:lumberkit/lumberkit.dart';

class LumberPickerStack extends StatefulWidget {
  final Function(String)? onPathUpdate;
  final Function(LumberPopOption) onSelect;
  final Color? foregroundColor;
  final Color? selectedForegroundColor;
  final Color? selectedBackgroundColor;
  final List<LumberPopOption> options;
  final bool scrolling;
  final TextAlign? textAlign;
  final double? topPadding;

  const LumberPickerStack({
    Key? key,
    this.onPathUpdate,
    required this.onSelect,
    this.foregroundColor,
    this.selectedForegroundColor,
    this.selectedBackgroundColor,
    required this.options,
    required this.scrolling,
    this.textAlign,
    this.topPadding,
  }) : super(key: key);

  @override
  State<LumberPickerStack> createState() => _LumberPickerStackState();
}

class _LumberPickerStackState extends State<LumberPickerStack> {
  final double _cellHeight = 50;
  int _hoverSelection = -1;

  Color backgrondColor(int index) {
    if (index == _hoverSelection)
      return widget.selectedBackgroundColor ?? Colors.white.withAlpha(50);
    return Colors.transparent;
  }

  Color primaryColor(int index) {
    if (index == _hoverSelection)
      return widget.selectedForegroundColor ??
          widget.foregroundColor ??
          Colors.white;
    return widget.foregroundColor ?? Colors.white;
  }

  Color secondaryColor(int index) => primaryColor(index).shade300;

  TextStyle textStyle(int index) => Theme.of(context)
      .textTheme
      .subtitle1!
      .copyWith(color: primaryColor(index));

  List<Widget> buildChildren() => widget.options.map(
        (option) {
          return InkWell(
            onHover: (hover) {
              if (hover) {
                setState(() => _hoverSelection = option.index);
              } else if (_hoverSelection == option.index) {
                setState(() => _hoverSelection = -1);
              }
            },
            onTap: () {
              if (option.onNewPath != null) {
                widget.onPathUpdate?.call(option.onNewPath!());
              } else {
                widget.onSelect(option);
              }
            },
            child: Container(
              color: backgrondColor(option.index),
              height: _cellHeight,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (option.icon != null)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Container(
                          width: 30,
                          height: 30,
                          child: Center(
                            child: LumberIcon(
                              data: option.icon!,
                              primaryColor: primaryColor(option.index),
                              secondaryColor: secondaryColor(option.index),
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                    if (option.title != null)
                      Expanded(
                        child: Text(
                          option.title!,
                          overflow: TextOverflow.ellipsis,
                          style: option.titleStyleOverrides
                                  ?.call(textStyle(option.index)) ??
                              textStyle(option.index),
                          textAlign: widget.textAlign ??
                              ((option.icon == null)
                                  ? TextAlign.center
                                  : TextAlign.left),
                        ),
                      ),
                    if (option.onNewPath != null &&
                        option.onSelect != null &&
                        option.index == _hoverSelection)
                      LumberButton(
                        label: "Select",
                        width: 70,
                        borderRadius: 5,
                        textStyle: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(color: Colors.white),
                        color: primaryColor(option.index).shade700,
                        onPressed: () => widget.onSelect(option),
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      ).toList();

  @override
  Widget build(BuildContext context) {
    List<LumberPopOption> options;
    options = widget.options;
    options.sort((a, b) => a.index.compareTo(b.index));
    if (widget.scrolling) {
      return Container(
        height: _cellHeight * widget.options.length,
        child: ListView(
          children: buildChildren(),
        ),
      );
    }

    return Container(
      height: _cellHeight * widget.options.length,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: buildChildren(),
      ),
    );
  }
}
