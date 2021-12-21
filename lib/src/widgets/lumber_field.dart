import 'package:flutter/material.dart';
import 'package:nanoid/async.dart';

class LumberField extends StatelessWidget {
  final String? label;
  final String? hint;
  final String? initialValue;
  final int? maxLength;
  final void Function(String?)? onSaved;
  final void Function(String?)? onSubmitted;
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
  final String? heroTag;
  final bool autofocus;
  final double? width;
  final double? height;
  final double? borderRadius;
  final TextAlign? textAlign;
  final bool autocorrect;
  final EdgeInsetsGeometry? externalPadding;
  final EdgeInsetsGeometry? internalPadding;

  LumberField({
    Key? key,
    required this.label,
    this.hint,
    this.initialValue,
    this.maxLength,
    this.onSaved,
    this.onSubmitted,
    this.onEdit,
    this.validator,
    this.textCapitalization = TextCapitalization.none,
    this.keyboardType,
    this.large = false,
    this.obscure = false,
    this.autofocus = false,
    this.icon,
    this.backgroundColor,
    this.borderColor,
    this.activeColor,
    this.style,
    this.hintStyle,
    this.heroTag,
    this.width,
    this.height,
    this.borderRadius = 20,
    this.externalPadding,
    this.internalPadding,
    this.textAlign,
    this.autocorrect = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: externalPadding ?? const EdgeInsets.all(0),
      child: Hero(
        tag: heroTag ?? nanoid(6),
        child: Container(
          width: width,
          height: height,
          padding: internalPadding ?? const EdgeInsets.all(0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(borderRadius ?? 0)),
            color: backgroundColor,
            border: borderColor != null
                ? Border.all(
                    width: 2.0,
                    color: borderColor!,
                  )
                : null,
          ),
          child: Center(
            child: TextFormField(
              textAlignVertical: TextAlignVertical.center,
              textAlign: textAlign ?? TextAlign.start,
              autofocus: autofocus,
              maxLength: maxLength,
              style: style,
              initialValue: initialValue,
              onChanged: onEdit,
              onSaved: onSaved,
              onFieldSubmitted: onSubmitted,
              validator: validator,
              textCapitalization: textCapitalization,
              maxLines: large ? null : 1,
              minLines: large ? 10 : null,
              keyboardType: keyboardType,
              obscureText: obscure,
              cursorColor: activeColor,
              autocorrect: autocorrect,
              decoration: InputDecoration(
                prefixIcon: icon != null ? Icon(icon) : null,
                hintText: label,
                hintStyle: hintStyle,
                border: InputBorder.none,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
