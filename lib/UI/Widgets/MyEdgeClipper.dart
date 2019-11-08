import 'package:flutter/material.dart';

class MyEdgeClipper extends CustomClipper<Path> {
  double clipHeight = null;
  MyEdgeClipper({@required this.clipHeight});
  @override
  Path getClip(Size size) {
    var path = Path();
    var height = clipHeight;
    path.lineTo(0.0, size.height - height);
    var firstEndPoint = Offset(size.width / 2, size.height - height);
    var firstControlPoint = Offset(size.width / 4, size.height);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy, firstEndPoint.dx, firstEndPoint.dy);
    var secondEndPoint = Offset(size.width, size.height - height);
    var secondControlPoint = Offset((size.width / 4) * 3, size.height - height - height);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy, secondEndPoint.dx, secondEndPoint.dy);
    path.lineTo(size.width, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    var clipper = oldClipper as MyEdgeClipper;
    return this.clipHeight != clipper.clipHeight;
  }
}