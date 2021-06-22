import 'package:flutter/material.dart';

extension ColorExtension on Color {
  MaterialColor get materialColor {
    List strengths = <double>[.05];
    final swatch = <int, Color>{};
    final int r = this.red, g = this.green, b = this.blue;

    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }
    strengths.forEach((strength) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    });
    return MaterialColor(this.value, swatch);
  }

  Color get shade50 => this.materialColor.shade50;
  Color get shade100 => this.materialColor.shade100;
  Color get shade200 => this.materialColor.shade200;
  Color get shade300 => this.materialColor.shade300;
  Color get shade400 => this.materialColor.shade400;
  Color get shade500 => this.materialColor.shade500;
  Color get shade600 => this.materialColor.shade600;
  Color get shade700 => this.materialColor.shade700;
  Color get shade800 => this.materialColor.shade800;
  Color get shade900 => this.materialColor.shade900;
}
