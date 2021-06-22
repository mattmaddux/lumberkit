import 'package:flutter/material.dart';

enum ScreenType {
  veryWide,
  wide,
  medium,
  narrow,
}

extension ScreenTypeExtension on ScreenType {
  static ScreenType from({required BuildContext context}) {
    double width = MediaQuery.of(context).size.width;
    if (width < 600) return ScreenType.narrow;
    if (width < 900) return ScreenType.medium;
    if (width < 1200) return ScreenType.wide;
    return ScreenType.veryWide;
  }
}

extension BuildContextExtension on BuildContext {
  ScreenType get screenType => ScreenTypeExtension.from(context: this);
  bool screenIsType({required ScreenType screenType}) =>
      this.screenType == screenType;
}
