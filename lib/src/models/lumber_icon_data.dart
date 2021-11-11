import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lumberkit/lumberkit.dart';

enum LumberIconType { regular, solid, light, brand, duotone, other }

class LumberIconData {
  final int code;
  final int? secondaryCode;
  final LumberIconType type;
  final String? fontFamily;

  LumberIconData({
    required this.code,
    this.secondaryCode,
    required this.type,
    this.fontFamily,
  });

  bool get isDuotone => secondaryCode != null;

  factory LumberIconData.fromString(String name) => LumberIconData.fromIconData(
      LumberIconList[name] ?? LumberIconList["question"]!);

  factory LumberIconData.fromJSON(Map<String, dynamic> json) => LumberIconData(
        code: json['code'],
        secondaryCode: json['secondaryCode'],
        type: LumberIconType.values
            .firstWhere((element) => json["type"] == describeEnum(element)),
        fontFamily: json['fontFamily'],
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
        'fontFamily': fontFamily,
      };
}
