
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'PieMenu.dart';

class PieTabBar extends StatefulWidget implements PreferredSizeWidget {
  PageController controller;
  List<Widget> children;
  Widget background;
  double radius;
  int centerTabIndex;
  double rotationRatio;
  Color selectedColor;
  Color unselectedColor;
  bool keepRotation;
  PieTabBar({
    @required this.controller,
    @required this.children,
    this.radius = 90.0,
    this.background,
    @required this.centerTabIndex,
    this.rotationRatio = 0.5,
    this.selectedColor,
    this.keepRotation = true,
    this.unselectedColor,
  });
  @override
  State<StatefulWidget> createState() {
    return _PieTabBarState();
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromWidth(180.0);
}

class _PieTabBarState extends State<PieTabBar> {
  double _menuAngle() {
    return ((widget.controller.page ?? 0) - widget.centerTabIndex - 1) * widget.rotationRatio;
  }
  @override
  Widget build(BuildContext context) {
    Widget buildingWidget = null;
    var tabIndex = 0;
    buildingWidget = Container(
      width: widget.radius * 2,
      height: widget.radius * 2,
      child: AnimatedBuilder(
        child: PieMenu(
          keepRotation: this.widget.keepRotation,
            background: widget.background,
            radius: widget.radius - 20,
            startAngle: -(3.14 / 2),
            endAngle: 3.14 - (3.14 / 2),
            divider: Container(
              width: 1.0,
              color: Colors.white12,
              height: 80.0,
            ),
            blurSigmaX: 15.0,
            blurSigmaY: 15.0,
            children: [
              SizedBox(),
              ...widget.children.map((widget){
                var index = tabIndex++;
                return IconButton(
                  icon: AnimatedBuilder(
                    animation: this.widget.controller,
                    builder: (context, widget){
                      var pageIndex = this.widget.controller.page ?? 0;
                      var colorPosition = 0.0;
                      var reverseIndex = tabIndex - 1 - index;
                      if (pageIndex > reverseIndex){
                        colorPosition = pageIndex - reverseIndex;
                      }
                      if (reverseIndex > pageIndex) {
                        colorPosition = reverseIndex - pageIndex;
                      }
                      if (colorPosition > 1) colorPosition = 1.0;
                      if (colorPosition < 0) colorPosition = 0.0;
                      var color = Color.lerp(this.widget.selectedColor, this.widget.unselectedColor, colorPosition);
                      var matrix = Matrix4.rotationZ(-_menuAngle());
                      var scale = 1.0 - (0.1 * colorPosition);
                      matrix.scale(scale, scale);
                      return Transform(
                        alignment: Alignment.center,
                        transform: matrix,
                        child: IconTheme(
                          data: IconThemeData(color: color),
                          child: widget,
                        ),
                      );
                    },
                    child: widget,
                  ),
                  onPressed: (){
                    var page = Directionality.of(context) == TextDirection.ltr ? index : this.widget.children.length - 1 - index;
                    this.widget.controller.animateToPage(page,
                      curve: Curves.easeInOutQuad,
                      duration: Duration(milliseconds: 700)
                    );
                  },
                );
              }),
            ]
        ),
        animation: widget.controller,
        builder: (context, _widget){
          return Transform.rotate(
              angle: _menuAngle(),
            child: _widget,
          );
        },
      ),
    );
    buildingWidget = Center(
      child: buildingWidget,
    );
    buildingWidget = Transform.translate(
      offset: Offset(0.0, widget.radius + 30),
      child: buildingWidget,
    );
    return buildingWidget;
  }
}