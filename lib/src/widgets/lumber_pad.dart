import 'package:flutter/material.dart';
import 'lumber_pad_components.dart';

class NumPad extends StatefulWidget {
  final Function(String)? onChanged;
  final Function(String)? onComplete;
  final Color buttonColor;
  final Color? indicatorColor;
  final TextStyle textStyle;
  final double buttonSize;
  final double? padding;
  final double? horizontalPadding;
  final double? verticalPadding;
  final double? indicatorHorizontalPadding;
  final double? indicatorVerticalPadding;

  const NumPad({
    Key? key,
    this.onChanged,
    this.onComplete,
    required this.buttonColor,
    this.indicatorColor,
    required this.textStyle,
    required this.buttonSize,
    this.padding,
    this.horizontalPadding,
    this.verticalPadding,
    this.indicatorVerticalPadding,
    this.indicatorHorizontalPadding,
  }) : super(key: key);

  @override
  _NumPadState createState() => _NumPadState();
}

class _NumPadState extends State<NumPad> {
  String _value = "";
  String? _currentKey;

  List<Widget> createRows(context) {
    return List<Widget>.generate(4, (row) => createRow(context, num: row));
  }

  void update(String addition) {
    if (_value.length < 6) {
      setState(() => _value += addition);
      if (widget.onChanged != null) widget.onChanged!(_value);
      if (_value.length == 6 && widget.onComplete != null) {
        Future.delayed(Duration(milliseconds: 250))
            .then((_) => widget.onComplete!(_value));
      }
    }
  }

  void remove() {
    if (_value.length > 0) {
      setState(() => _value = _value.substring(0, _value.length - 1));
      if (widget.onChanged != null) widget.onChanged!(_value);
    }
  }

  void setCurrentKey(String? newValue) {
    setState(() => _currentKey = newValue);
  }

  void clear() {
    setState(() => _value = "");
    if (widget.onChanged != null) widget.onChanged!(_value);
  }

  void resopondToKey(RawKeyEvent event) {
    if (event.character == null) {
      setCurrentKey(null);
      return;
    }
    if (int.tryParse(event.character ?? "") != null) {
      setCurrentKey(event.character);
      update(event.character!);
      return;
    }
    if (event.character == "Backspace") {
      setCurrentKey(event.character);
      remove();
    }
    if (event.character == "x" || event.character == "Escape") {
      setCurrentKey("x");
      clear();
    }
  }

  Widget createRow(context, {required int num}) {
    double hPadding;
    double vPadding;
    if (widget.padding != null) {
      hPadding = widget.padding!;
      vPadding = widget.padding!;
    } else {
      hPadding = widget.horizontalPadding ?? 0;
      vPadding = widget.verticalPadding ?? 0;
    }

    if (num == 3) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconPadButton(
            icon: Icons.clear,
            onTap: clear,
            size: widget.buttonSize,
            color: Theme.of(context).accentColor,
            style: widget.textStyle,
            horizontalPadding: hPadding,
            verticalPadding: vPadding,
            selected: _currentKey == "x",
          ),
          NumPadButton(
            value: 0,
            onTap: update,
            size: widget.buttonSize,
            color: Theme.of(context).accentColor,
            style: widget.textStyle,
            horizontalPadding: hPadding,
            verticalPadding: vPadding,
            selected: "0" == _currentKey,
          ),
          IconPadButton(
            icon: Icons.backspace,
            onTap: remove,
            size: widget.buttonSize,
            color: Theme.of(context).accentColor,
            style: widget.textStyle,
            horizontalPadding: hPadding,
            verticalPadding: vPadding,
            selected: _currentKey == "Backspace",
          ),
        ],
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List<Widget>.generate(3, (column) {
        int buttonValue = (num * 3) + column + 1;
        return NumPadButton(
          value: buttonValue,
          onTap: update,
          size: widget.buttonSize,
          color: Theme.of(context).accentColor,
          style: widget.textStyle,
          horizontalPadding: hPadding,
          verticalPadding: vPadding,
          selected: "$buttonValue" == _currentKey,
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    FocusNode node = FocusNode();
    FocusScope.of(context).requestFocus(node);
    return Expanded(
      child: RawKeyboardListener(
        autofocus: true,
        focusNode: node,
        onKey: resopondToKey,
        child: Container(
          child: Column(
            children: [
              IndicatorRow(
                currentValue: _value,
                dotSize: widget.buttonSize * 0.2,
                color: widget.buttonColor,
                horizontalPadding: widget.indicatorHorizontalPadding ?? 8,
                verticalPadding: widget.indicatorVerticalPadding ?? 15,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: createRows(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
