import 'package:dolqun_movies/StateManagement/ModelProvider.dart';
import 'package:flutter/cupertino.dart';

class ColorThemeModel extends Model {
  Color textColor;
  Color backgroundColor;
  Color maskColor;
  Color iconColor;

  ColorThemeModel({
    this.backgroundColor,
    this.maskColor,
    this.textColor
  });
}