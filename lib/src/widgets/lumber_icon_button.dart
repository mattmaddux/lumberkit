import 'package:flutter/material.dart';

import 'package:lumberkit/lumberkit.dart';

class LumberIconButton extends StatefulWidget {
  final LumberIconData data;
  final double? iconSize;
  final double? buttonSize;
  final Color color;
  final Color? secondaryColor;
  final Color? backgroundColor;
  final Color? hoverColor;
  final Color? hoverSecondaryColor;
  final Color? hoverBackgroundColor;
  final Color? pressedColor;
  final Color? pressedSecondaryColor;
  final Color? pressedBackgroundColor;
  final double? borderRadius;
  final Function onPressed;

  const LumberIconButton({
    Key? key,
    required this.data,
    this.iconSize,
    this.buttonSize,
    required this.color,
    this.secondaryColor,
    this.backgroundColor,
    this.hoverColor,
    this.hoverSecondaryColor,
    this.hoverBackgroundColor,
    this.pressedColor,
    this.pressedSecondaryColor,
    this.pressedBackgroundColor,
    this.borderRadius,
    required this.onPressed,
  }) : super(key: key);

  @override
  _LumberIconButtonState createState() => _LumberIconButtonState();
}

class _LumberIconButtonState extends State<LumberIconButton> {
  bool _hovering = false;
  bool _pressed = false;

  Color get primaryColor {
    if (_pressed) {
      return widget.pressedColor ?? widget.color;
    } else if (_hovering) {
      return widget.hoverColor ?? widget.color;
    }
    return widget.color;
  }

  Color? get secondaryColor {
    if (_pressed) {
      return widget.pressedSecondaryColor ?? widget.secondaryColor;
    } else if (_hovering) {
      return widget.hoverSecondaryColor ?? widget.secondaryColor;
    }
    return widget.secondaryColor;
  }

  Color? get backgroundColor {
    if (_pressed) {
      return widget.pressedBackgroundColor ?? widget.backgroundColor;
    } else if (_hovering) {
      return widget.hoverBackgroundColor ?? widget.backgroundColor;
    }
    return widget.backgroundColor;
  }

  // @override
  // Widget build(BuildContext context) {
  //   return InkWell(
  //     onHover: (hovering) => setState(() => _hovering = hovering),
  //     onTapDown: (details) => setState(() => _pressed = true),
  //     splashColor: Colors.transparent,
  //     hoverColor: Colors.transparent,
  //     focusColor: Colors.transparent,
  //     highlightColor: Colors.transparent,
  //     onTap: () {
  //       setState(() => _pressed = false);
  //       widget.onPressed();
  //     },
  //     child: Container(
  //       decoration: BoxDecoration(
  //         color: backgroundColor,
  //         borderRadius: (widget.borderRadius != null)
  //             ? BorderRadius.circular(widget.borderRadius!)
  //             : null,
  //       ),
  //       width: widget.buttonSize,
  //       height: widget.buttonSize,
  //       child: Center(
  //         child: LumberIcon(
  //           data: widget.data,
  //           size: widget.iconSize,
  //           primaryColor: primaryColor,
  //           secondaryColor: secondaryColor,
  //         ),
  //       ),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: (widget.borderRadius != null)
            ? BorderRadius.circular(widget.borderRadius!)
            : null,
      ),
      width: widget.buttonSize,
      height: widget.buttonSize,
      child: Center(
        child: InkWell(
          onHover: (hovering) => setState(() => _hovering = hovering),
          onTapDown: (details) => setState(() => _pressed = true),
          splashColor: Colors.transparent,
          hoverColor: Colors.transparent,
          focusColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () {
            setState(() => _pressed = false);
            widget.onPressed();
          },
          child: LumberIcon(
            data: widget.data,
            size: widget.iconSize,
            primaryColor: primaryColor,
            secondaryColor: secondaryColor,
          ),
        ),
      ),
    );
  }
}
