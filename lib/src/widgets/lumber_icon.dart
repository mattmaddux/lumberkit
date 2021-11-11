import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lumberkit/src/models/lumber_icon_data.dart';

class LumberIcon extends StatelessWidget {
  final LumberIconData data;
  final double? size;
  final Color? primaryColor;
  final Color? secondaryColor;

  const LumberIcon({
    Key? key,
    required this.data,
    this.size,
    this.primaryColor,
    this.secondaryColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (data.type) {
      case LumberIconType.regular:
        return FaIcon(
          IconDataRegular(data.code),
          size: size,
          color: primaryColor,
        );
      case LumberIconType.solid:
        return FaIcon(
          IconDataSolid(data.code),
          size: size,
          color: primaryColor,
        );
      case LumberIconType.light:
        return FaIcon(
          IconDataLight(data.code),
          size: size,
          color: primaryColor,
        );
      case LumberIconType.brand:
        return FaIcon(
          IconDataBrands(data.code),
          size: size,
          color: primaryColor,
        );
      case LumberIconType.duotone:
        return FaDuotoneIcon(
          IconDataDuotone(
            data.code,
            secondary: IconDataDuotone(data.secondaryCode!),
          ),
          size: size,
          primaryColor: primaryColor,
          secondaryColor: secondaryColor,
        );
      case LumberIconType.other:
        return Icon(
          IconData(data.code, fontFamily: data.fontFamily),
          size: size,
          color: primaryColor,
        );
    }
  }
}
