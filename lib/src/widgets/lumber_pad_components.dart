import 'package:flutter/material.dart';
import 'package:lumberkit/lumberkit.dart';

class IndicatorRow extends StatelessWidget {
  final String currentValue;
  final double dotSize;
  final Color color;
  final double horizontalPadding;
  final double verticalPadding;

  const IndicatorRow({
    Key? key,
    required this.currentValue,
    required this.dotSize,
    required this.color,
    required this.horizontalPadding,
    required this.verticalPadding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.only(bottom: verticalPadding),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List<Widget>.generate(
            6,
            (index) => IndicatorDot(
              size: dotSize,
              filled: currentValue.length - 1 >= index,
              color: color,
              padding: horizontalPadding,
            ),
          ),
        ),
      ),
    );
  }
}

class IndicatorDot extends StatelessWidget {
  final double size;
  final bool filled;
  final Color color;
  final double padding;

  const IndicatorDot({
    Key? key,
    required this.size,
    required this.filled,
    required this.color,
    required this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: padding),
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(size / 2),
            color: filled ? color : color.withOpacity(0.4),
            border: Border.all(
                color: color.withOpacity(filled ? 0 : 1), width: size * 0.15)),
      ),
    );
  }
}

class RawPadButton extends StatefulWidget {
  final Widget child;
  final Function() onTap;
  final double size;
  final Color color;
  final double verticalPadding;
  final double horizontalPadding;
  final TextStyle style;
  final bool selected;

  const RawPadButton({
    Key? key,
    required this.child,
    required this.onTap,
    required this.size,
    required this.color,
    required this.verticalPadding,
    required this.horizontalPadding,
    required this.style,
    this.selected = false,
  }) : super(key: key);

  @override
  _RawPadButtonState createState() => _RawPadButtonState();
}

class _RawPadButtonState extends State<RawPadButton> {
  bool _pressed = false;
  bool get _shouldShowSelected => _pressed || widget.selected;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: widget.verticalPadding,
          horizontal: widget.horizontalPadding),
      child: Container(
        width: widget.size,
        height: widget.size,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(widget.size / 2),
          color: widget.color.withOpacity(_shouldShowSelected ? 0.2 : 0.3),
          border: Border.all(
              color: widget.color.withOpacity(_shouldShowSelected ? 0.7 : 1.0),
              width: 3.0),
        ),
        child: Container(
          child: InkWell(
            onTapDown: (_) {
              setState(() => _pressed = true);
            },
            onTap: () {
              setState(() => _pressed = false);
              widget.onTap();
            },
            child: Center(
              child: widget.child,
            ),
          ),
        ),
      ),
    );
  }
}

class NumPadButton extends StatelessWidget {
  final int value;
  final Function(String) onTap;
  final double size;
  final Color color;
  final double verticalPadding;
  final double horizontalPadding;
  final TextStyle style;
  final bool selected;

  const NumPadButton({
    Key? key,
    required this.value,
    required this.onTap,
    required this.size,
    required this.color,
    required this.verticalPadding,
    required this.horizontalPadding,
    required this.style,
    this.selected = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RawPadButton(
      onTap: () => onTap("$value"),
      size: size,
      color: color,
      verticalPadding: verticalPadding,
      horizontalPadding: horizontalPadding,
      style: style,
      child: Text(
        "$value",
        style: style.copyWith(color: color.shade900),
      ),
      selected: selected,
    );
  }
}

class IconPadButton extends StatelessWidget {
  final IconData icon;
  final Function() onTap;
  final double size;
  final Color color;
  final double verticalPadding;
  final double horizontalPadding;
  final TextStyle style;
  final bool selected;

  const IconPadButton({
    Key? key,
    required this.icon,
    required this.onTap,
    required this.size,
    required this.color,
    required this.verticalPadding,
    required this.horizontalPadding,
    required this.style,
    this.selected = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RawPadButton(
      onTap: onTap,
      size: size,
      color: color,
      verticalPadding: verticalPadding,
      horizontalPadding: horizontalPadding,
      style: style,
      child: Icon(
        icon,
        color: color.shade900,
      ),
      selected: selected,
    );
  }
}
