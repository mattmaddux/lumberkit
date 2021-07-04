import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:nanoid/nanoid.dart';

class AutoImage extends StatelessWidget {
  final String asset;
  final String? package;
  final double? width;
  final double? height;
  final double? size;
  final String? heroTag;

  const AutoImage(
      {Key? key,
      required this.asset,
      this.package,
      this.width,
      this.height,
      this.size,
      this.heroTag})
      : super(key: key);

  Widget build(BuildContext context) {
    if (kIsWeb) {
      return Hero(
        tag: heroTag ?? nanoid(6),
        child: Image.network(
          'assets/${package == null ? '' : 'packages/$package/'}$asset',
          height: size ?? height,
          width: size ?? width,
        ),
      );
    }

    if (size != null || width != null || height != null) {
      return Hero(
        tag: heroTag ?? "",
        child: SizedBox(
          width: size ?? width,
          height: size ?? height,
          child: Image.asset(
            asset,
            package: package,
          ),
        ),
      );
    }

    return Hero(
      tag: heroTag ?? nanoid(6),
      child: Image.asset(
        asset,
        package: package,
      ),
    );
  }
}
