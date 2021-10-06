import 'package:flutter/material.dart';

enum LumberPopOrientation {
  bottom,
  bottomRight,
  bottomLeft,
}

class LumberPopButton extends StatefulWidget {
  final Widget Function(BuildContext, Function(), Function()) childBuilder;
  final Widget Function(BuildContext, Function()) popUpBuilder;
  final double popUpWidth;
  final double? popUpHeight;
  final Color? popUpColor;
  final double? borderRadius;
  final bool clickAwayDismissable;
  final LumberPopOrientation orientation;

  const LumberPopButton({
    Key? key,
    required this.childBuilder,
    required this.popUpBuilder,
    this.popUpHeight,
    required this.popUpWidth,
    this.popUpColor,
    this.borderRadius,
    this.clickAwayDismissable = true,
    this.orientation = LumberPopOrientation.bottom,
  }) : super(key: key);

  @override
  _LumberPopButtonState createState() => _LumberPopButtonState();
}

class _LumberPopButtonState extends State<LumberPopButton> {
  GlobalKey _key = GlobalKey();

  OverlayEntry? _overlayEntry;
  Size? widgetSize;
  Offset? widgetPosition;
  bool showing = false;
  late OverlayEntry _dismissOverlay = OverlayEntry(
    builder: (context) {
      return GestureDetector(
        onTap: dismiss,
        child: Container(
          color: Colors.transparent,
        ),
      );
    },
  );

  void findButton() {
    RenderBox? renderBox =
        _key.currentContext?.findRenderObject() as RenderBox?;
    widgetSize = renderBox?.size;
    widgetPosition = renderBox?.localToGlobal(Offset.zero);
  }

  double calcLeft() {
    switch (widget.orientation) {
      case LumberPopOrientation.bottom:
        double diff = widgetSize!.width - widget.popUpWidth;
        return widgetPosition!.dx + (diff / 2);
      case LumberPopOrientation.bottomRight:
        return widgetPosition!.dx;
      case LumberPopOrientation.bottomLeft:
        double diff = widgetSize!.width - widget.popUpWidth;
        return widgetPosition!.dx + diff;
    }
  }

  Alignment get arrowAlignment {
    switch (widget.orientation) {
      case LumberPopOrientation.bottom:
        return Alignment.topCenter;
      case LumberPopOrientation.bottomRight:
        return Alignment.topLeft;
      case LumberPopOrientation.bottomLeft:
        return Alignment.topRight;
    }
  }

  OverlayEntry? _overlay() {
    if (widgetSize == null || widgetPosition == null) return null;
    return OverlayEntry(
      builder: (context) {
        return Positioned(
          top: widgetPosition!.dy + widgetSize!.height,
          left: calcLeft(),
          width: widget.popUpWidth,
          height: widget.popUpHeight,
          child: Material(
            color: Colors.transparent,
            child: Stack(
              children: [
                Align(
                  alignment: arrowAlignment,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: ClipPath(
                      clipper: ArrowClipper(),
                      child: Container(
                        width: 17,
                        height: 17,
                        color: widget.popUpColor ?? Colors.white,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: ClipRRect(
                    borderRadius:
                        BorderRadius.circular(widget.borderRadius ?? 0),
                    child: Container(
                      width: widget.popUpWidth,
                      decoration: BoxDecoration(
                        color: widget.popUpColor ?? Colors.white,
                        // borderRadius:
                        //     BorderRadius.circular(widget.borderRadius ?? 0),
                      ),
                      child: widget.popUpBuilder(context, dismiss),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void toggle() {
    if (!showing) {
      show();
    } else {
      dismiss();
    }
  }

  void show() {
    findButton();
    _overlayEntry = _overlay();
    OverlayState? overlayState = Overlay.of(context);
    if (_overlayEntry != null && overlayState != null) {
      if (widget.clickAwayDismissable) overlayState.insert(_dismissOverlay);
      overlayState.insert(_overlayEntry!);
      showing = true;
    }
  }

  void dismiss() {
    _overlayEntry?.remove();
    if (widget.clickAwayDismissable) _dismissOverlay.remove();
    showing = false;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      key: _key,
      child: widget.childBuilder(context, show, dismiss),
    );
  }
}

class ArrowClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(0, size.height);
    path.lineTo(size.width / 2, size.height / 2);
    path.lineTo(size.width, size.height);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
