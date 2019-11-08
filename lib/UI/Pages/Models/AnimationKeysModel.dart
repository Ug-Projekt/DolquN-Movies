

import 'package:dolqun_movies/StateManagement/ModelProvider.dart';
import 'package:dolqun_movies/UI/Widgets/PositionHero.dart';
import 'package:flutter/cupertino.dart';

class AnimationKeysModel with Model {
  List<RenderObjectKeyPair> settingsIconKeys = List.generate(3, (index) => RenderObjectKeyPair(
    keyOfParent: GlobalKey(),
    keyOfWidget: GlobalKey()
  ));
  List<RenderObjectKeyPair> cartIconKeys = List.generate(3, (index) => RenderObjectKeyPair(
      keyOfParent: GlobalKey(),
      keyOfWidget: GlobalKey()
  ));
  List<RenderObjectKeyPair> shareIconKeys = List.generate(3, (index) => RenderObjectKeyPair(
      keyOfParent: GlobalKey(),
      keyOfWidget: GlobalKey()
  ));
  List<RenderObjectKeyPair> favoriteIconKeys = List.generate(3, (index) => RenderObjectKeyPair(
      keyOfParent: GlobalKey(),
      keyOfWidget: GlobalKey()
  ));
  List<RenderObjectKeyPair> accountIconKeys = List.generate(3, (index) => RenderObjectKeyPair(
      keyOfParent: GlobalKey(),
      keyOfWidget: GlobalKey()
  ));
  List<RenderObjectKeyPair> searchIconKeys = List.generate(3, (index) => RenderObjectKeyPair(
      keyOfParent: GlobalKey(),
      keyOfWidget: GlobalKey()
  ));
}