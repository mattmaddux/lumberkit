import 'package:flutter/material.dart';

enum ArrowDirection { up, down, left, right }

class SimpleArrow extends StatelessWidget {
  final ArrowDirection direction;
  final double size;
  final Color color;

  const SimpleArrow({
    Key? key,
    required this.direction,
    required this.size,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: ArrowClipper(direction: direction),
      child: Container(
        width:
            (direction == ArrowDirection.up || direction == ArrowDirection.down)
                ? size
                : size / 2,
        height:
            (direction == ArrowDirection.up || direction == ArrowDirection.down)
                ? size / 2
                : size,
        color: color,
      ),
    );
  }
}

class ArrowClipper extends CustomClipper<Path> {
  final ArrowDirection direction;

  ArrowClipper({required this.direction});

  @override
  Path getClip(Size size) {
    Path path = Path();

    switch (direction) {
      case ArrowDirection.up:
        path.moveTo(0, size.height);
        path.lineTo(size.width / 2, 0);
        path.lineTo(size.width, size.height);
        break;
      case ArrowDirection.down:
        path.moveTo(0, 0);
        path.lineTo(size.width / 2, size.height);
        path.lineTo(size.width, 0);
        break;
      case ArrowDirection.left:
        path.moveTo(size.width, 0);
        path.lineTo(0, size.height / 2);
        path.lineTo(size.width, size.height);
        break;
      case ArrowDirection.right:
        path.moveTo(0, 0);
        path.lineTo(size.width, size.height / 2);
        path.lineTo(0, size.height);
        break;
    }

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
