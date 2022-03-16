import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:nanoid/nanoid.dart';

class LumberTextButton extends StatefulWidget {
  final String label;
  final void Function() onPressed;
  final Color? color;
  final TextStyle? textStyle;
  final EdgeInsetsGeometry? padding;
  final double? borderRadius;
  final double? minimumScale;
  final bool loading;
  final String? heroTag;

  LumberTextButton({
    Key? key,
    required this.label,
    required this.onPressed,
    this.color = Colors.blueAccent,
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
  }) : super(key: key);

  _LumberTextButton createState() => _LumberTextButton();
}

class _LumberTextButton extends State<LumberTextButton>
    with SingleTickerProviderStateMixin {
  Animation<double>? animation;
  AnimationController? controller;
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

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  Widget getChild(BuildContext context) {
    if (widget.loading) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 100, vertical: 10),
        child: LoadingIndicator(
          indicatorType: Indicator.ballPulse,
          color: widget.color,
        ),
      );
    }
    TextStyle style = widget.textStyle ??
        Theme.of(context).textTheme.bodyText1 ??
        TextStyle();
    return Center(
      child: Text(
        widget.label,
        style:
            widget.color == null ? style : style.copyWith(color: widget.color),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => controller!.forward(),
      onTapUp: (_) => controller!.reverse(),
      onTap: widget.onPressed,
      child: Transform.scale(
        scale: animation!.value,
        child: Hero(
          tag: widget.heroTag ?? nanoid(6),
          child: Container(
            padding: widget.padding,
            child: getChild(context),
          ),
        ),
      ),
    );
  }
}
