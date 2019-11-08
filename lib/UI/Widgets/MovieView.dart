

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dolqun_movies/Entities/Movie.dart';
import 'package:dolqun_movies/StateManagement/ModelProvider.dart';
import 'package:dolqun_movies/UI/Pages/Models/ColorThemeModel.dart';
import 'package:dolqun_movies/UI/Widgets/MyEdgeClipper.dart';
import 'package:flutter/material.dart';

class MovieView extends StatelessWidget {
  Movie movie = null;
  Function() onTab = null;
  MovieView({@required this.movie, @required this.onTab});

  @override
  Widget build(BuildContext context) {
    Widget buildingWidget = ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(8.0)),
      child: ClipPath(
        clipper: MyEdgeClipper(clipHeight: 7.0),
        child: CachedNetworkImage(imageUrl: movie.image,
          width: double.infinity,
          placeholder: (context, url) => Container(
            color: Colors.blue.withOpacity(0.04),
          ),
          fit: BoxFit.cover,
        ),
      ),
    );
    buildingWidget = Container(
      child: Column(
        children: <Widget>[
          Expanded(
            child: buildingWidget,
          ),
          SizedBox(
            width: double.infinity,
            child: Text(movie.name, maxLines: 1, style: TextStyle(fontSize: 10.0, color: Colors.blue), textAlign: TextAlign.center,),
          )
        ],
      ),
      width: 100.0,
      height: 160.0,
      margin: EdgeInsets.all(5.0),
    );
    buildingWidget = GestureDetector(
      child: buildingWidget,
      onTap: onTab,
    );
    return buildingWidget;
  }
}