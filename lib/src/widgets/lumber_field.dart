import 'package:flutter/material.dart';

class LumberField extends StatelessWidget {
  final String? label;
  final String? hint;
  final String? initialValue;
  final int? maxLength;
  final void Function(String?)? onSaved;
  final void Function(String?)? onEdit;
  final String? Function(String?)? validator;
  final TextCapitalization textCapitalization;
  final TextInputType? keyboardType;
  final IconData? icon;
  final Color? backgroundColor;
  final Color? borderColor;
  final Color? activeColor;
  final bool large;
  final bool obscure;
  final TextStyle? style;
  final TextStyle? hintStyle;

  LumberField({
    Key? key,
    required this.label,
    this.hint,
    this.initialValue,
    this.maxLength,
    this.onSaved,
    this.onEdit,
    this.validator,
    this.textCapitalization = TextCapitalization.none,
    this.keyboardType,
    this.large = false,
    this.obscure = false,
    this.icon,
    this.backgroundColor,
    this.borderColor,
    this.activeColor,
    this.style,
    this.hintStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          color: backgroundColor,
          border: borderColor != null
              ? Border.all(
                  width: 2.0,
                  color: borderColor!,
                )
              : null,
        ),
        child: TextFormField(
          maxLength: maxLength,
          style: style,
          initialValue: initialValue,
          onChanged: onEdit,
          onSaved: onSaved,
          validator: validator,
          textCapitalization: textCapitalization,
          maxLines: large ? null : 1,
          minLines: large ? 10 : null,
          keyboardType: keyboardType,
          obscureText: obscure,
          cursorColor: activeColor,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.all(12.0),
            prefixIcon: icon != null ? Icon(icon) : null,
            hintText: label,
            hintStyle: hintStyle,
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}
