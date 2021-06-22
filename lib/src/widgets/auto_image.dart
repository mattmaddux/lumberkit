import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class AutoImage extends StatelessWidget {
  final String asset;
  final String? package;
  final double? width;
  final double? height;
  final double? size;

  const AutoImage(
      {Key? key,
      required this.asset,
      this.package,
      this.width,
      this.height,
      this.size})
      : super(key: key);

  Widget build(BuildContext context) {
    if (kIsWeb) {
      return Image.network(
        'assets/${package == null ? '' : 'packages/$package/'}$asset',
        height: size ?? height,
        width: size ?? width,
      );
    }

    if (size != null || width != null || height != null) {
      return SizedBox(
        width: size ?? width,
        height: size ?? height,
        child: Image.asset(
          asset,
          package: package,
        ),
      );
    }

    return Image.asset(
      asset,
      package: package,
    );
  }
}
