// import 'dart:html';
// import 'dart:ui' as ui;

// import 'package:flutter/material.dart';

// class HTMLImage extends StatelessWidget {
//   final String url;

//   const HTMLImage({
//     Key? key,
//     required this.url,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     // https://github.com/flutter/flutter/issues/41563
//     // ignore: undefined_prefixed_name
//     ui.platformViewRegistry.registerViewFactory(
//       url,
//       (int _) => ImageElement()..src = url,
//     );
//     return HtmlElementView(
//       viewType: url,
//     );
//   }
// }
