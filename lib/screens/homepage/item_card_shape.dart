import 'package:flutter/material.dart';

class ItemCardShape extends ShapeBorder {
  final double width;
  final double height;

  const ItemCardShape(this.width, this.height);

  @override
  Path getOuterPath(Rect rect, {TextDirection textDirection}) {
    return getClip(Size(width, height));
  }

  Path getClip(Size size) {
    Path clippedPath = Path();
    double curveDistance = 40;

    clippedPath.moveTo(0, size.height * 0.2);
    clippedPath.lineTo(0, size.height - curveDistance);
    clippedPath.quadraticBezierTo(
        1, size.height - 1, 0 + curveDistance, size.height);
    clippedPath.lineTo(size.width - curveDistance, size.height);
    clippedPath.quadraticBezierTo(size.width + 1, size.height - 1, size.width,
        size.height - curveDistance);
    clippedPath.lineTo(size.width, 0 + curveDistance);
    clippedPath.quadraticBezierTo(size.width - 1, 0,
        size.width - curveDistance - 5, 0 + curveDistance / 3);
    clippedPath.lineTo(curveDistance, size.height * 0.175);
    clippedPath.quadraticBezierTo(
        0, (size.height * 0.15) + 10, 0, size.height * 0.3);
    return clippedPath;
  }

  @override
  EdgeInsetsGeometry get dimensions => throw UnimplementedError();

  @override
  ShapeBorder scale(double t) {
    return null;
  }

  @override
  Path getInnerPath(Rect rect, {TextDirection textDirection}) {
    // TODO: implement getInnerPath
    throw UnimplementedError();
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection textDirection}) {
    // TODO: implement paint
  }
}
