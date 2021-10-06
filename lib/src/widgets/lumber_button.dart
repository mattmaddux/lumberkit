import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:nanoid/nanoid.dart';

class LumberButton extends StatefulWidget {
  final String label;
  final void Function() onPressed;
  final double? height;
  final double? width;
  final Color? color;
  final Color? hoverColor;
  final TextStyle? textStyle;
  final EdgeInsetsGeometry? padding;
  final double? borderRadius;
  final double? minimumScale;
  final bool loading;
  final String? heroTag;
  final TextAlign? textAlign;

  LumberButton({
    Key? key,
    required this.label,
    required this.onPressed,
    this.height,
    this.width,
    this.color = Colors.blueAccent,
    this.hoverColor,
    this.textStyle = const TextStyle(
      color: Colors.white,
      fontSize: 20,
      fontWeight: FontWeight.w600,
    ),
    this.padding = const EdgeInsets.all(10),
    this.borderRadius = 15,
    this.minimumScale = 0.98,
    this.loading = false,
    this.heroTag,
    this.textAlign,
  }) : super(key: key);

  _LumberButton createState() => _LumberButton();
}

class _LumberButton extends State<LumberButton>
    with SingleTickerProviderStateMixin {
  Animation<double>? animation;
  AnimationController? controller;
  bool _hovering = false;
  // double _currentSize = 1.0;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 45),
    );

    Animation<double> curve = CurvedAnimation(
      parent: controller!,
      curve: Curves.bounceIn,
    );

    animation = Tween<double>(
      begin: 1.0,
      end: widget.minimumScale,
    ).animate(curve)
      ..addListener(() => setState(() {}));
  }

  Widget getChild() {
    if (widget.loading) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 100, vertical: 10),
        child: LoadingIndicator(
          indicatorType: Indicator.ballPulse,
          color: Colors.white,
        ),
      );
    }
    return Center(
      child: Text(
        widget.label,
        textAlign: widget.textAlign ?? TextAlign.center,
        style: widget.textStyle,
      ),
    );
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: GestureDetector(
        onTapDown: (_) => controller!.forward(),
        onTapUp: (_) => controller!.reverse(),
        onTap: widget.onPressed,
        child: Transform.scale(
          scale: animation!.value,
          child: Hero(
            tag: widget.heroTag ?? nanoid(6),
            child: Container(
              width: widget.width,
              height: widget.height,
              padding: widget.padding,
              decoration: BoxDecoration(
                borderRadius: widget.borderRadius != null
                    ? BorderRadius.circular(widget.borderRadius!)
                    : null,
                color: (_hovering && widget.hoverColor != null)
                    ? widget.hoverColor!
                    : widget.color!,
              ),
              child: getChild(),
            ),
          ),
        ),
      ),
    );
  }
}
