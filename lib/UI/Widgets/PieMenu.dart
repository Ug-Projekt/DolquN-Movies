import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'dart:math' as Math;

class PieMenu extends StatelessWidget {
  List<Widget> children;
  double blurSigmaX;
  double blurSigmaY;
  double startAngle;
  double endAngle;
  double radius;
  Widget divider;
  Widget background;
  bool keepRotation;
  PieMenu({
    @required this.children,
    this.blurSigmaX: 10.0,
    this.blurSigmaY: 10.0,
    this.startAngle = 0.0,
    this.endAngle = Math.pi * 2,
    this.radius = 40.0,
    this.divider,
    this.background,
    this.keepRotation = false,
  });
  @override
  Widget build(BuildContext context) {
    Widget buildingWidget = null;
    var index0 = 0;
    var index1 = 0;
    var singleAngle = (endAngle - startAngle) / children.length;
    buildingWidget = Stack(
      children: [
        if (this.background != null) this.background,
        if (divider != null)
          ...this.children.map((widget){
            return Positioned.fill(
              child: Center(
                child: Transform.rotate(
                  angle: (index0++ * singleAngle + startAngle),
                  alignment: Alignment.center,
                  child: Transform.translate(
                    offset: Offset(0.0, -radius),
                    child: divider,
                  ),
                ),
              ),
            );
          }).toList(),
        ...this.children.map((widget){
          var angle = index1++ * singleAngle + startAngle + singleAngle / 2;
          return Positioned.fill(
            child: Center(
              child: Transform.rotate(
                angle: angle,
                alignment: Alignment.center,
                child: Transform.translate(
                  offset: Offset(0.0, -radius),
                  child: Transform.rotate(
                    angle: this.keepRotation ? -angle : 0,
                    child: widget,
                  ),
                ),
              ),
            ),
          );
        }).toList()
      ]
    );
    buildingWidget = BackdropFilter(
      child: buildingWidget,
      filter: ImageFilter.blur(sigmaX: blurSigmaX, sigmaY: blurSigmaY),
    );
    buildingWidget = ClipPath(
      clipper: _Clipper(),
      child: buildingWidget,
    );
    return buildingWidget;
  }
}

class _Clipper extends CustomClipper<Path> {
  var _inirialized = false;
  @override
  Path getClip(Size size) {
    var path = new Path();
    path.addArc(Rect.fromLTWH(0, 0, size.width, size.height), 0, Math.pi * 2);
    return path;
  }

  @override
  bool shouldReclip(_Clipper oldClipper) {
    if (!_inirialized) {
      _inirialized = true;
      return _inirialized;
    }
    return !_inirialized;
  }

}