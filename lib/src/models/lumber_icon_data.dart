import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

enum LumberIconType { regular, solid, light, brand, duotone }

class LumberIconData {
  final int code;
  final int? secondaryCode;
  final LumberIconType type;

  LumberIconData({required this.code, this.secondaryCode, required this.type});

  bool get isDuotone => secondaryCode != null;

  factory LumberIconData.fromJSON(Map<String, dynamic> json) => LumberIconData(
        code: json['code'],
        secondaryCode: json['secondaryCode'],
        type: LumberIconType.values
            .firstWhere((element) => json["type"] == describeEnum(element)),
      );

  factory LumberIconData.fromIconData(IconData iconData) {
    int code = iconData.codePoint;
    int? secondaryCode;
    LumberIconType type = LumberIconType.regular;

    if (iconData is IconDataLight) type = LumberIconType.light;
    if (iconData is IconDataSolid) type = LumberIconType.solid;
    if (iconData is IconDataBrands) type = LumberIconType.brand;
    if (iconData is IconDataDuotone) {
      secondaryCode = iconData.secondary?.codePoint;
      type = LumberIconType.duotone;
    }

    return LumberIconData(code: code, secondaryCode: secondaryCode, type: type);
  }
  Map<String, dynamic> toJSON() => {
        'code': code,
        'secondaryCode': secondaryCode,
        'type': describeEnum(type),
      };
}
