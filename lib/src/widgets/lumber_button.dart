import 'package:flutter/material.dart';

class LumberButton extends StatefulWidget {
  final String label;
  final void Function() onPressed;
  final double? height;
  final double? width;
  final Color? color;
  final TextStyle? textStyle;
  final EdgeInsetsGeometry? padding;
  final double? borderRadius;
  final double? minimumScale;

  LumberButton(
      {Key? key,
      required this.label,
      required this.onPressed,
      this.height,
      this.width,
      this.color = Colors.blueAccent,
      this.textStyle = const TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
      this.padding = const EdgeInsets.all(10),
      this.borderRadius = 15,
      this.minimumScale = 0.98})
      : super(key: key);

  _LumberButton createState() => _LumberButton();
}

class _LumberButton extends State<LumberButton>
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
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => controller!.forward(),
      onTapUp: (_) => controller!.reverse(),
      onTap: widget.onPressed,
      child: Transform.scale(
        scale: animation!.value,
        child: Container(
          width: widget.width,
          height: widget.height,
          padding: widget.padding,
          decoration: BoxDecoration(
            borderRadius: widget.borderRadius != null
                ? BorderRadius.circular(widget.borderRadius!)
                : null,
            color: widget.color,
          ),
          child: Center(
            child: Text(
              widget.label,
              style: widget.textStyle,
            ),
          ),
        ),
      ),
    );
  }
}
