import 'package:flutter/material.dart';

class ScreenType {
  final DeviceWidth width;
  final DeviceHeight height;

  ScreenType({required this.width, required this.height});

  factory ScreenType.from(BuildContext context) => ScreenType(
        width: DeviceWidthExtension.from(context),
        height: DeviceHeightExtension.from(context),
      );

  bool get isNarrow => width.matches(DeviceWidth.narrow);
  bool get isMedium => width.matches(DeviceWidth.medium);
  bool get isWide => width.matches(DeviceWidth.wide);
  bool get isVeryWide => width.matches(DeviceWidth.veryWide);

  bool get isVeryShort => height.matches(DeviceHeight.veryShort);
  bool get isShort => height.matches(DeviceHeight.short);
  bool get tall => height.matches(DeviceHeight.tall);
}

enum DeviceWidth {
  veryWide,
  wide,
  medium,
  narrow,
}

enum DeviceHeight {
  veryShort,
  short,
  tall,
}

extension DeviceWidthExtension on DeviceWidth {
  static DeviceWidth from(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    if (width < 600) return DeviceWidth.narrow;
    if (width < 900) return DeviceWidth.medium;
    if (width < 1200) return DeviceWidth.wide;
    return DeviceWidth.veryWide;
  }

  bool matches(DeviceWidth comp) => this == comp;
}

extension DeviceHeightExtension on DeviceHeight {
  static DeviceHeight from(BuildContext context) {
    double width = MediaQuery.of(context).size.height;
    if (width < 600) return DeviceHeight.veryShort;
    if (width < 1000) return DeviceHeight.short;
    return DeviceHeight.tall;
  }

  bool matches(DeviceHeight comp) => this == comp;
}

extension BuildContextExtension on BuildContext {
  ScreenType get screen => ScreenType.from(this);
}
