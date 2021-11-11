import 'package:flutter/material.dart';
import 'package:lumberkit/src/widgets/simple_arrow.dart';

enum LumberPopOrientation {
  top,
  topRight,
  topLeft,
  bottom,
  bottomRight,
  bottomLeft,
}

extension LumberPopOrientationExtenon on LumberPopOrientation {
  bool get top =>
      this == LumberPopOrientation.top ||
      this == LumberPopOrientation.topRight ||
      this == LumberPopOrientation.topLeft;
  bool get bottom =>
      this == LumberPopOrientation.bottom ||
      this == LumberPopOrientation.bottomRight ||
      this == LumberPopOrientation.bottomLeft;

  bool get right =>
      this == LumberPopOrientation.topRight ||
      this == LumberPopOrientation.bottomRight;
  bool get left =>
      this == LumberPopOrientation.topLeft ||
      this == LumberPopOrientation.bottomLeft;
  bool get center =>
      this == LumberPopOrientation.bottom || this == LumberPopOrientation.top;

  Alignment get arrowAlignment {
    switch (this) {
      case LumberPopOrientation.top:
        return Alignment.bottomCenter;
      case LumberPopOrientation.topRight:
        return Alignment.bottomLeft;
      case LumberPopOrientation.topLeft:
        return Alignment.bottomRight;
      case LumberPopOrientation.bottom:
        return Alignment.topCenter;
      case LumberPopOrientation.bottomRight:
        return Alignment.topLeft;
      case LumberPopOrientation.bottomLeft:
        return Alignment.topRight;
    }
  }

  ArrowDirection get arrowDirection {
    switch (this) {
      case LumberPopOrientation.top:
      case LumberPopOrientation.topRight:
      case LumberPopOrientation.topLeft:
        return ArrowDirection.down;
      case LumberPopOrientation.bottom:
      case LumberPopOrientation.bottomRight:
      case LumberPopOrientation.bottomLeft:
        return ArrowDirection.up;
    }
  }
}

class LumberPopButton extends StatefulWidget {
  final Widget Function(BuildContext, Function() open, Function() close)
      childBuilder;
  final Widget Function(BuildContext, Function()) popUpBuilder;
  final double popUpWidth;
  final double popUpHeight;
  final Color? popUpColor;
  final double? borderRadius;
  final bool clickAwayDismissable;
  final LumberPopOrientation? orientation;
  final double arrowSize;
  final double padding;

  const LumberPopButton({
    Key? key,
    required this.childBuilder,
    required this.popUpBuilder,
    required this.popUpHeight,
    required this.popUpWidth,
    this.popUpColor,
    this.borderRadius,
    this.clickAwayDismissable = true,
    this.orientation,
    this.arrowSize = 16,
    this.padding = 8,
  }) : super(key: key);

  @override
  _LumberPopButtonState createState() => _LumberPopButtonState();
}

class _LumberPopButtonState extends State<LumberPopButton> {
  GlobalKey _key = GlobalKey();

  OverlayEntry? _overlayEntry;
  Size? widgetSize;
  Offset? widgetPosition;
  LumberPopOrientation? orientation;
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

  void getOrientation() {
    if (widget.orientation != null) {
      orientation = widget.orientation!;
    }

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double leftSpace = widgetPosition!.dx;
    double rightSpace = width - (widgetPosition!.dx + widgetSize!.width);
    double topSpace = widgetPosition!.dy;
    double bottomSpace = height - (widgetPosition!.dy + widgetSize!.height);

    if (bottomSpace > topSpace) {
      if (leftSpace < widget.popUpWidth / 2) {
        orientation = LumberPopOrientation.bottomRight;
      } else if (rightSpace < widget.popUpWidth / 2) {
        orientation = LumberPopOrientation.bottomLeft;
      } else {
        orientation = LumberPopOrientation.bottom;
      }
    } else {
      if (leftSpace < widget.popUpWidth / 2) {
        orientation = LumberPopOrientation.topRight;
      } else if (rightSpace < widget.popUpWidth / 2) {
        orientation = LumberPopOrientation.topLeft;
      } else {
        orientation = LumberPopOrientation.top;
      }
    }
  }

  void findButton() {
    RenderBox? renderBox =
        _key.currentContext?.findRenderObject() as RenderBox?;
    widgetSize = renderBox?.size;
    widgetPosition = renderBox?.localToGlobal(Offset.zero);
    getOrientation();
  }

  double calcTop() {
    if (orientation!.bottom) return widgetPosition!.dy + widgetSize!.height;
    return widgetPosition!.dy - widget.popUpHeight - widget.arrowSize;
  }

  double calcLeft() {
    if (orientation!.center) {
      double diff = widgetSize!.width - widget.popUpWidth;
      return widgetPosition!.dx + (diff / 2);
    }
    if (orientation!.left) {
      double diff = widgetSize!.width - widget.popUpWidth;
      return widgetPosition!.dx + diff;
    }
    return widgetPosition!.dx;
  }

  double calcArrowPadding() => widgetSize!.width / 2 - widget.arrowSize / 2;

  EdgeInsetsGeometry getMainBodyPadding() {
    switch (widget.orientation) {
      case LumberPopOrientation.bottom:
      case LumberPopOrientation.bottomLeft:
      case LumberPopOrientation.bottomRight:
        return EdgeInsets.only(top: widget.arrowSize);
      default:
        return EdgeInsets.only(bottom: widget.arrowSize);
    }
  }

  OverlayEntry? _overlay() {
    if (widgetSize == null || widgetPosition == null || orientation == null)
      return null;
    return OverlayEntry(
      builder: (context) {
        return Positioned(
          top: calcTop(),
          left: calcLeft(),
          width: widget.popUpWidth,
          height: widget.popUpHeight + (widget.arrowSize / 2) + widget.padding,
          child: Material(
            color: Colors.transparent,
            child: Padding(
              padding: EdgeInsets.only(
                top: orientation!.bottom ? widget.padding : 0,
                bottom: orientation!.top ? widget.padding : 0,
              ),
              child: Stack(
                children: [
                  Align(
                    alignment: orientation!.arrowAlignment,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: calcArrowPadding(),
                      ),
                      child: SimpleArrow(
                        direction: orientation!.arrowDirection,
                        size: widget.arrowSize,
                        color: widget.popUpColor ?? Colors.white,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: orientation!.bottom ? (widget.arrowSize / 2) : 0,
                      bottom: orientation!.top ? (widget.arrowSize / 2) : 0,
                    ),
                    child: ClipRRect(
                      borderRadius:
                          BorderRadius.circular(widget.borderRadius ?? 0),
                      child: Container(
                        width: widget.popUpWidth,
                        height: widget.popUpHeight,
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
