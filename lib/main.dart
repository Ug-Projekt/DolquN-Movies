

import 'package:dolqun_movies/Interface/Network.dart';
import 'package:dolqun_movies/StateManagement/ModelProvider.dart';
import 'package:dolqun_movies/UI/Pages/MainPage.dart';
import 'package:dolqun_movies/UI/Pages/Models/AnimationKeysModel.dart';
import 'package:dolqun_movies/UI/Pages/Models/ColorThemeModel.dart';
import 'package:dolqun_movies/UI/Pages/Models/HomePageModel.dart';
import 'package:flutter/material.dart';

import 'UI/Pages/Models/MainPageAnimationModel.dart';

void main(){
  runApp(_buildApp());
}

Widget _buildApp(){
  final api = NetworkInterface(url: "https://d.dolqun.net");
  Widget buildingWidget = MainPage();

  Color textColor = Colors.white70;
  Color backgroundColor = Color(0xff182432);

  buildingWidget = MaterialApp(
    home: buildingWidget,
    theme: ThemeData(
        platform: TargetPlatform.iOS,
        scaffoldBackgroundColor: backgroundColor,
        textTheme: TextTheme(
            body1: TextStyle(
                color: textColor
            )
        ),
      buttonTheme: ButtonThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0)
        ),
        buttonColor: Colors.white.withOpacity(0.5)
      ),
      fontFamily: "ukij-cjk",
    ),
  );

  buildingWidget = ModelProvider<HomePageModel>(
    child: buildingWidget,
    model: HomePageModel(api),
  );

  buildingWidget = ModelProvider<AnimationKeysModel>(
    child: buildingWidget,
    model: AnimationKeysModel(),
  );
  buildingWidget = ModelProvider<MainPageAnimationModel>(
    child: buildingWidget,
    model: MainPageAnimationModel(),
  );
  buildingWidget = ModelProvider<ColorThemeModel>(
    model: ColorThemeModel(
      backgroundColor: backgroundColor,
      textColor: textColor,
      maskColor: Colors.white.withOpacity(0.04),
    ),
    child: buildingWidget,
  );

  return buildingWidget;
}
