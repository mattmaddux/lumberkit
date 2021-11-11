import 'package:flutter/material.dart';

import 'package:lumberkit/lumberkit.dart';
import 'package:lumberkit/src/widgets/lumber_picker_stack.dart';

class LumberBrowserPopPicker extends StatelessWidget {
  final String popupHeading;
  final String? initialPath;
  final Widget Function(BuildContext, Function(), Function()) builder;
  final Future<List<LumberPopOption>> Function(String?) optionsFutureGenerator;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final Color? selectedForegroundColor;
  final Color? selectedBackgroundColor;
  final double popUpHeight;
  final double popUpWidth;
  final TextAlign? textAlign;
  final bool? directorySelection;

  LumberBrowserPopPicker({
    Key? key,
    required this.popupHeading,
    this.initialPath,
    required this.builder,
    required this.optionsFutureGenerator,
    this.backgroundColor,
    this.foregroundColor,
    this.selectedForegroundColor,
    this.selectedBackgroundColor,
    this.popUpHeight = 300,
    this.popUpWidth = 150,
    this.textAlign,
    this.directorySelection = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LumberPopButton(
      popUpColor: backgroundColor?.shade400 ?? Colors.grey[700],
      borderRadius: 8,
      childBuilder: builder,
      popUpWidth: this.popUpWidth,
      popUpHeight: this.popUpHeight,
      popUpBuilder: (context, onDismiss) => LumberBrowser(
        heading: popupHeading,
        initialPath: initialPath,
        optionsFutureGenerator: optionsFutureGenerator,
        onDismiss: onDismiss,
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
        selectedForegroundColor: selectedForegroundColor,
        selectedBackgroundColor: selectedBackgroundColor,
        textAlign: textAlign,
        directorySelection: directorySelection,
      ),
    );
  }
}

class LumberBrowser extends StatefulWidget {
  final String heading;
  final String? initialPath;
  final Future<List<LumberPopOption>> Function(String?) optionsFutureGenerator;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final Color? selectedForegroundColor;
  final Color? selectedBackgroundColor;
  final TextAlign? textAlign;
  final bool? directorySelection;
  final Function() onDismiss;

  const LumberBrowser({
    Key? key,
    required this.heading,
    this.initialPath,
    required this.optionsFutureGenerator,
    this.backgroundColor,
    this.foregroundColor,
    this.selectedForegroundColor,
    this.selectedBackgroundColor,
    this.textAlign,
    this.directorySelection,
    required this.onDismiss,
  }) : super(key: key);

  @override
  _LumberBrowserState createState() => _LumberBrowserState();
}

class _LumberBrowserState extends State<LumberBrowser> {
  String? path;

  void up() {
    if (path == null) {
      return;
    }
    if (path == '/') {
      return;
    }
    if (path!.lastIndexOf("/") == -1) {
      setState(() => path = null);
      return;
    }
    final newPath = path!.substring(0, path!.lastIndexOf('/'));
    setState(() => path = newPath);
  }

  String lastPathComponent() {
    if (path == null || path == '/') {
      return '';
    }
    return path!.substring(path!.lastIndexOf('/') + 1);
  }

  int pathComponents() => path?.split('/').length ?? 0;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: widget.optionsFutureGenerator(path),
      builder: (context, AsyncSnapshot<List<LumberPopOption>> snap) {
        if (snap.data == null)
          return Container(
            child: Center(
              child: SizedBox.shrink(),
            ),
          );
        List<LumberPopOption> options = snap.data!;
        options.sort((a, b) => a.index.compareTo(b.index));
        return Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 50.0),
              child: LumberPickerStack(
                foregroundColor: widget.foregroundColor,
                selectedForegroundColor: widget.selectedForegroundColor,
                selectedBackgroundColor: widget.selectedBackgroundColor,
                scrolling: true,
                textAlign: widget.textAlign,
                options: options,
                topPadding: 40,
                onPathUpdate: (newPath) => setState(() => path = newPath),
                onSelect: (option) {
                  option.onSelect?.call();
                  widget.onDismiss();
                },
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                width: MediaQuery.of(context).size.width,
                color: widget.backgroundColor,
                height: 50,
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            widget.heading,
                            style: Theme.of(context)
                                .textTheme
                                .headline6!
                                .copyWith(color: widget.foregroundColor),
                          ),
                          Text(
                            lastPathComponent(),
                            style: Theme.of(context)
                                .textTheme
                                .caption!
                                .copyWith(color: widget.foregroundColor),
                          ),
                        ],
                      ),
                    ),
                    if (pathComponents() > 0)
                      Align(
                        alignment: Alignment.centerLeft,
                        child: IconButton(
                          color: widget.foregroundColor,
                          icon: Icon(Icons.arrow_back),
                          onPressed: () => up(),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
