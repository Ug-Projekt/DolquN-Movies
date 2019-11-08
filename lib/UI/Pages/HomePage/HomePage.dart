import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dolqun_movies/Entities/Movie.dart';
import 'package:dolqun_movies/StateManagement/ModelProvider.dart';
import 'package:dolqun_movies/UI/Pages/HomePage/DetailsPage.dart';
import 'package:dolqun_movies/UI/Pages/Models/AnimationKeysModel.dart';
import 'package:dolqun_movies/UI/Pages/Models/ColorThemeModel.dart';
import 'package:dolqun_movies/UI/Pages/Models/HomePageModel.dart';
import 'package:dolqun_movies/UI/Pages/Models/MainPageAnimationModel.dart';
import 'package:dolqun_movies/UI/Widgets/MovieView.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ScrollController _controller = ScrollController();
  var _oldScrollOffset = 0.0;
  var _top = 0.0;

  @override
  void initState() {
//    print("Home page init state");
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var keyModel = ModelContainer.of<AnimationKeysModel>(context).model;
    var keyOfParent = keyModel.settingsIconKeys[1].keyOfParent;
    keyModel.shareIconKeys[1].keyOfParent = keyOfParent;
    keyModel.cartIconKeys[1].keyOfParent = keyOfParent;
    keyModel.favoriteIconKeys[1].keyOfParent = keyOfParent;
//    keyModel.searchIconKeys[0].keyOfWidget = keyModel.searchIconKeys[1].keyOfWidget;
//    keyModel.searchIconKeys[0].keyOfParent = keyOfParent;
    keyModel.searchIconKeys[1].keyOfParent = keyOfParent;
    keyModel.accountIconKeys[1].keyOfParent = keyOfParent;
    var animationModel = ModelContainer.of<MainPageAnimationModel>(context).model;
    return ModelDescendant<HomePageModel>(
      child: (context, model){
        if (model.initializationResult == null) model.initializationResult = model.initialize();
        Widget buildingWidget = SizedBox(
          key: keyModel.settingsIconKeys[1].keyOfParent,
          child: Stack(
            children: <Widget>[
              Positioned.fill(
                child: FutureBuilder<bool>(
                  future: model.initializationResult,
                  builder: (context, snapshot){
                    Widget buildingWidget = Center(child: CircularProgressIndicator(),);
                    if (snapshot.hasError) {
                      buildingWidget = Center(child: Text(snapshot.error.toString()),);
                    }
                    if (snapshot.hasData) {
                      buildingWidget = ListView(
                        controller: _controller,
                        children: [
                          SizedBox(height: 120.0,),
                          ...model.homeList.data.where((item) => item.items.length > 0).map((item) => _buildCategoryItem(item)).toList(),
                          SizedBox(height: 50.0,)
                        ],
                      );
                    }
                    return buildingWidget;
                  },
                ),
              ),
              AnimatedBuilder(
                animation: _controller,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(0.0),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 20.0, sigmaY: 20.0),
                    child: ModelDescendant<ColorThemeModel>(
                      child: (context, child) => Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Padding(child: SizedBox(width: 10.0, height: 10.0, key: keyModel.accountIconKeys[1].keyOfWidget ,), padding: EdgeInsets.all(10.0),),
                          Padding(child: SizedBox(width: 10.0, height: 10.0, key: keyModel.searchIconKeys[1].keyOfWidget, ), padding: EdgeInsets.all(10.0),),
                          Padding(child: SizedBox(width: 10.0, height: 10.0, key: keyModel.cartIconKeys[1].keyOfWidget), padding: EdgeInsets.all(10.0),),
                          Padding(child: SizedBox(width: 10.0, height: 10.0, key: keyModel.favoriteIconKeys[1].keyOfWidget), padding: EdgeInsets.all(10.0),),
                          Padding(child: SizedBox(width: 10.0, height: 10.0, key: keyModel.settingsIconKeys[1].keyOfWidget, child: Icon(Icons.settings, color: Colors.transparent,),), padding: EdgeInsets.all(10.0),),
                          Padding(child: SizedBox(width: 10.0, height: 10.0, key: keyModel.shareIconKeys[1].keyOfWidget), padding: EdgeInsets.all(10.0),),
                        ],
                      ),
                      onChanged: (context, child, model) => Container(
                        padding: EdgeInsets.only(bottom: 20.0),
                        alignment: Alignment.bottomCenter,
                        color: model.maskColor,
                        child: child,
                      ),
                    ),
                  ),
                ),
                builder: (context, child){
                  var offset = 0.0;
                  if (_controller.positions.isNotEmpty) offset = _controller.offset ?? 0.0;
//                  print("Offset: $offset, old Offset: $_oldScrollOffset, top: $_top");
                  if (_oldScrollOffset < offset && offset > 500) {
                    if (_top > -120) {
                      _top -= offset - _oldScrollOffset;
                      if (_top < -120) {
                        _top = -120;
                      }
                      SchedulerBinding.instance.addPostFrameCallback((_) => animationModel.applyChanges());
                    }
                  }
                  if (_oldScrollOffset > offset) {
                    if (_top < 0) {
                      _top += _oldScrollOffset - offset;
                      if (_top > 0) {
                        _top = 0;
                      }
                      SchedulerBinding.instance.addPostFrameCallback((_) => animationModel.applyChanges());
                    }
                  }
                  _oldScrollOffset = offset;
                  return Positioned(
                    top: _top,
                    right: 0,
                    left: 0,
                    height: 120.0,
                    child: child,
                  );
                },
              )
            ],
          ),
        );
        return buildingWidget;
      });
  }

  Widget _buildCategoryItem(MovieCategory category){
    Widget buildingWidget;
    buildingWidget = Container(
      margin: EdgeInsets.all(5.0).copyWith(top: 0.0),
      padding: EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.01),
        borderRadius: BorderRadius.all(Radius.circular(15.0))
      ),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(child: Text(category.name),),
              FlatButton(child: Text("تىخىمۇ كۆپ...", style: TextStyle(color: Colors.blue),)),
            ],
          ),
          Wrap(
            children: category.items.map((item) => _buildMovieItem(item)).toList(),
          )
        ],
      ),
    );
    return buildingWidget;
  }

  Widget _buildMovieItem(Movie movie) {
    return Hero(
      tag: movie.id,
      child: MovieView(
        movie: movie,
        onTab: ()async {
          await Navigator.of(context).push(MaterialPageRoute(builder: (context) => DetailsPage(movie: movie,)));
        },
      ),
    );
  }
}
