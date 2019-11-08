import 'package:flutter/material.dart';
import 'dart:math' as Math;

class PositionHero extends StatefulWidget {
  Widget child;
  Listenable animation;
  double Function() animationValue;
  List<RenderObjectKeyPair> keyOfTargetWidgets;
  Offset Function(RenderObjectKeyPair keys, Offset offset) offsetTransformer;

  PositionHero({
    @required this.animation,
    @required this.child,
    @required this.keyOfTargetWidgets,
    @required this.offsetTransformer,
    @required this.animationValue,
  });

  @override
  State<StatefulWidget> createState() {
    return _PositionHeroState();
  }
}

class _RenderObjectPair {
  RenderBox parent;
  RenderBox widget;
  _RenderObjectPair({this.widget, this.parent});
}

class _PositionHeroState extends State<PositionHero> {
  List<_RenderObjectPair> _widgets;

  @override
  Widget build(BuildContext context) {
    if (_widgets == null) _widgets = List.generate(widget.keyOfTargetWidgets.length, (index) => _RenderObjectPair());

    Widget buildingWidget = null;
    buildingWidget = AnimatedBuilder(
      animation: widget.animation,
      builder: (context, widget) {
        for (var index = 0; index < _widgets.length; index++) {
          RenderObject getRenderBox(RenderObject oldRenderObject, GlobalKey key) {
            if (oldRenderObject != null && !oldRenderObject.attached) oldRenderObject = null;
            if (oldRenderObject == null){
              var context = key.currentContext;
              if (context != null) oldRenderObject = context.findRenderObject();
            }
            return oldRenderObject;
          }
          var mapping = _widgets[index];
            mapping.widget = getRenderBox(mapping.widget, this.widget.keyOfTargetWidgets[index].keyOfWidget);
            mapping.parent = getRenderBox(mapping.parent, this.widget.keyOfTargetWidgets[index].keyOfParent);
            _widgets[index] = mapping;
        }
        var index = 0;
        var offsets = this._widgets.map((mapping){
          if (mapping.parent == null || mapping.widget == null) return Offset.zero;
          var offset = mapping.widget.globalToLocal(Offset.zero, ancestor: mapping.parent);
          var size = mapping.widget.size;
          offset = Offset(offset.dx + size.width / 2, offset.dy + size.height / 2);
          return this.widget.offsetTransformer(this.widget.keyOfTargetWidgets[index++], offset);
        }).toList();

//        offsets = [Offset(356.6, 511.3), Offset(200, 100), Offset(100, 400)];
        if (offsets.isEmpty) return widget;
        var xs = offsets.map((offset) => offset.dx).toList();
        var ys = offsets.map((offset) => offset.dy).toList();
        var x = doubleLerp(xs, this.widget.animationValue());
        var y = doubleLerp(ys, this.widget.animationValue());
        var matrix = Matrix4.translationValues(x, y, 0.0);

        return Transform(
          transform: matrix,
          alignment: Alignment.center,
          child: widget,
        );
      },
      child: widget.child,
    );
    return buildingWidget;
  }
}

class RenderObjectKeyPair{
  GlobalKey keyOfParent;
  GlobalKey keyOfWidget;
  RenderObjectKeyPair({
    this.keyOfParent,
    this.keyOfWidget
  });
}

double doubleLerp(List<double> values, double offset) {
  var value = 0.0;
  var indexOfFirstValue = offset.floor();
  var indexOfSecondValue = indexOfFirstValue + 1;
  var firstValue = values.last;
  var secondValue = values.last;
  if (indexOfFirstValue < values.length) firstValue = values[indexOfFirstValue];
  if (indexOfSecondValue < values.length)
    secondValue = values[indexOfSecondValue];
  offset %= 1;
  var max = Math.max(firstValue, secondValue);
  var min = Math.min(firstValue, secondValue);
  if (firstValue > secondValue) {
    value = max - ((max - min) * offset);
  }
  if (secondValue > firstValue) {
    value = ((max - min) * offset) + min;
  }
  if (firstValue == secondValue) value = firstValue;
  return value;
}
