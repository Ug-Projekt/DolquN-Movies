import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dolqun_movies/StateManagement/ModelProvider.dart';
import 'package:dolqun_movies/UI/Pages/FilterPage.dart';
import 'package:dolqun_movies/UI/Pages/HomePage/HomePage.dart';
import 'package:dolqun_movies/UI/Pages/Models/ColorThemeModel.dart';
import 'package:dolqun_movies/UI/Pages/ProfilePage.dart';
import 'package:dolqun_movies/UI/Widgets/PieMenu.dart';
import 'package:dolqun_movies/UI/Widgets/PieTabBar.dart';
import 'package:dolqun_movies/UI/Widgets/PositionHero.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';

import 'Models/AnimationKeysModel.dart';
import 'Models/MainPageAnimationModel.dart';

class MainPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MainPageState();

}

class _MainPageState extends State<MainPage> with AutomaticKeepAliveClientMixin<MainPage> {
  final widthOfNavigation = 250.0;
  final heightOfNavigation = 50.0;
  PageController controller = PageController(initialPage: 1);
  MainPageAnimationModel animationModel;
  ColorThemeModel colorThemeModel;
  var _points = [0.0, 1.0, 0.0];

  @override
  bool get wantKeepAlive => true;

  void handlePageUpdate(){
    if (this.controller.positions.isNotEmpty) {
      animationModel.page = controller.page ?? 0.0;
      animationModel.applyChanges();
    }

    var temp = 0.0;
    temp = animationModel.page;
    temp = doubleLerp(_points, temp);
    var color = Color.lerp(Theme.of(context).scaffoldBackgroundColor, Colors.white, temp);
    colorThemeModel.backgroundColor = color;
    color = Color.lerp(Theme.of(context).textTheme.body1.color, Colors.blue, temp);
    colorThemeModel.textColor = color;
    color = Color.lerp(Colors.white.withOpacity(0.04), Colors.black.withOpacity(0.04), temp);
    colorThemeModel.maskColor = color;
    color = Color.lerp(Colors.blue, Colors.red, temp);
    colorThemeModel.iconColor = color;
    colorThemeModel.applyChanges();
  }

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((duration){
      this.controller.addListener(handlePageUpdate);
      handlePageUpdate();
      try {
        FlutterStatusbarcolor.setStatusBarColor(Colors.transparent);
//        FlutterStatusbarManager.setFullscreen(true);
      }
      catch (exception) {

      }
    });
  }

  @override
  void dispose() {
    this.controller.removeListener(handlePageUpdate);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var keyModel = ModelContainer.of<AnimationKeysModel>(context).model;
    animationModel = ModelContainer.of<MainPageAnimationModel>(context).model;
    colorThemeModel = ModelContainer.of<ColorThemeModel>(context).model;

    Widget content = Column(
      children: <Widget>[
        Expanded(
          child: PageView(
            controller: controller,
            children: <Widget>[
              ProfilePage(),
              HomePage(),
              FilterPage(),
            ],
          ),
        )
      ],
    );

    content = Stack(
      children: <Widget>[
        content,
        Positioned(
          bottom: 0.0,
          left: 0.0,
          right: 0.0,
          child: buildNavigation(),
        ),
        buildAnimationButton(keyModel.settingsIconKeys, IconButton(
          padding: EdgeInsets.all(0.0),
          alignment: Alignment.topLeft,
          icon: _buildColoredIcon(Icons.settings),
          onPressed: (){
            print("Settings button clicked!");
          },
        )),
        buildAnimationButton(keyModel.cartIconKeys, IconButton(
          padding: EdgeInsets.all(0.0),
          alignment: Alignment.topLeft,
          icon: _buildColoredIcon(Icons.shopping_cart),
          onPressed: (){
            print("shopping_cart button clicked!");
          },
        )),
        buildAnimationButton(keyModel.shareIconKeys, IconButton(
          padding: EdgeInsets.all(0.0),
          alignment: Alignment.topLeft,
          icon: _buildColoredIcon(Icons.mobile_screen_share),
          onPressed: (){
            print("mobile_screen_share button clicked!");
          },
        )),
        buildAnimationButton(keyModel.favoriteIconKeys, IconButton(
          padding: EdgeInsets.all(0.0),
          alignment: Alignment.topLeft,
          icon: _buildColoredIcon(Icons.favorite),
          onPressed: (){
            print("favorite button clicked!");
          },
        )),
        buildAnimationButton(keyModel.accountIconKeys, IconButton(
          padding: EdgeInsets.all(0.0),
          alignment: Alignment.topLeft,
          icon: _buildColoredIcon(Icons.person),
          onPressed: (){
            controller.animateToPage(0, duration: Duration(milliseconds: 1000), curve: Curves.elasticOut);
          },
        )),
        buildAnimationButton(keyModel.searchIconKeys, IconButton(
          padding: EdgeInsets.all(0.0),
          alignment: Alignment.topLeft,
          icon: _buildColoredIcon(Icons.search),
          onPressed: (){
            controller.animateToPage(1, duration: Duration(milliseconds: 1000), curve: Curves.elasticOut);
          },
        )),
      ],
    );

    content = AnimatedBuilder(
      animation: colorThemeModel.notifier,
      child: content,
      builder: (context, child){
        return Scaffold(
          body: child,
          backgroundColor: colorThemeModel.backgroundColor,
        );
      }
    );
    content = Directionality(
      child: content,
      textDirection: TextDirection.rtl,
    );
    super.build(context);
    return content;
  }

  Widget buildAnimationButton(List<RenderObjectKeyPair> keys, Widget icon){
    return Positioned(
      left: 0.0,
      child: PositionHero(
        child: icon,
        animation: animationModel.notifier,
        keyOfTargetWidgets: keys,
        offsetTransformer: (key, offset) => Offset(-offset.dx, -offset.dy),
        animationValue: () => animationModel.page
      ),
    );
  }

  Widget _buildColoredIcon(IconData icon){
    return ModelDescendant<ColorThemeModel>(
      onChanged: (context, _, model) => Icon(icon, color: model.iconColor,),
    );
  }

//  Widget buildNavigation(){
//    return Center(
//      child: ClipPath(
//        clipper: NavigationClipper(),
//        child: BackdropFilter(
//          filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
//          child: Container(
//            alignment: Alignment.bottomCenter,
//            height: heightOfNavigation,
//            width: widthOfNavigation,
//            color: Colors.white.withOpacity(0.04),
//            child: TabBar(
//              unselectedLabelColor: Colors.white30,
//              labelColor: Colors.blue,
//              controller: controller,
//              labelPadding: EdgeInsets.only(bottom: 10.0),
//              tabs: <Widget>[
//                Icon(Icons.person),
//                Icon(Icons.apps),
//                Icon(Icons.all_inclusive),
//              ],
//            ),
//          ),
//        ),
//      ),
//    );
//  }

  Widget buildNavigation(){
    return PieTabBar(
      rotationRatio: 0.4,
      centerTabIndex: 1,
      selectedColor: Theme.of(this.context).primaryColor,
      unselectedColor: Colors.white54,
      background: Container(
        color: Colors.blue.withOpacity(0.1),
      ),
      radius: 100.0,
      controller: controller,
      children: <Widget>[
        ModelDescendant<ColorThemeModel>(
          onChanged: (context, _, model) => Icon(Icons.looks, color: model.iconColor,),
        ),
        ModelDescendant<ColorThemeModel>(
          onChanged: (context, _, model) => Icon(Icons.apps, color: model.iconColor,),
        ),
        ModelDescendant<ColorThemeModel>(
          onChanged: (context, _, model) => Icon(Icons.person, color: model.iconColor,),
        ),
      ],
    );
  }
}

//class NavigationClipper extends CustomClipper<Path> {
//  var initialize = false;
//
//  @override
//  Path getClip(Size size) {
//    var sizeOfRect = size.height;
//    var path = Path();
//    path.lineTo(size.width - sizeOfRect / 2, 0);
//    var rect = Rect.fromLTWH(size.width - sizeOfRect, 0.0, sizeOfRect, sizeOfRect);
//    path.arcTo(rect, -(3.14 / 2), 3.14 / 2, false);
//    path.lineTo(size.width, size.height);
//    path.lineTo(0.0, size.height);
//    rect = Rect.fromLTWH(0.0, 0.0, sizeOfRect, sizeOfRect);
//    path.lineTo(0.0, sizeOfRect / 2);
//    path.arcTo(rect, 3.14, 3.14 / 2, false);
//    return path;
//  }
//
//  @override
//  bool shouldReclip(CustomClipper<Path> oldClipper) {
//    if (!initialize) {
//      initialize = true;
//      return initialize;
//    }
//    return !initialize;
//  }
//}