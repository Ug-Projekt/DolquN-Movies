

import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dolqun_movies/Entities/Movie.dart';
import 'package:dolqun_movies/UI/Widgets/MovieView.dart';
import 'package:dolqun_movies/UI/Widgets/MyEdgeClipper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class DetailsPage extends StatefulWidget {
  Movie movie;
  @override
  State<StatefulWidget> createState() => _DetailsPageState();

  DetailsPage({this.movie});
}

class _DetailsPageState extends State<DetailsPage> with SingleTickerProviderStateMixin {
  var _controller = ScrollController();

  double getPosition(){
    var position = 0.0;
    if (_controller.positions.isNotEmpty) position = _controller.offset;
    return position;
  }

  @override
  Widget build(BuildContext context) {
    Widget buildingWidget = null;
    buildingWidget = Scaffold(
      body: Stack(
        children: <Widget>[
          Positioned.fill(
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, _){
                var opacity = 0.0;
                opacity = (getPosition() / 100);
                if (opacity < 0) opacity = 0;
                if (opacity > 1) opacity = 1;
                return Container(
                  color: Color.lerp(Theme.of(context).scaffoldBackgroundColor, Color(0xff080613), opacity)
                );
              },
            ),
          ),
          Positioned.fill(
            child: ListView(
              controller: _controller,
              padding: EdgeInsets.only(top: 0.0),
              children: <Widget>[
                SizedBox(
                    height: 370,
                    child: Stack(
                      children: <Widget>[
                        Positioned.fill(
                          child: ClipPath(
                            clipper: MyEdgeClipper(clipHeight: 20.0),
                            child: CachedNetworkImage(imageUrl: widget.movie.image, fit: BoxFit.cover,),
                          ),
                        ),
                        Positioned.fill(
                          child: Container(
                            margin: EdgeInsets.all(10.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                SizedBox(height: 10.0,),
                                Expanded(
                                  child: AnimatedBuilder(
                                    animation: _controller,
                                    child: Container(
                                      decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(spreadRadius: 70.0, blurRadius: 70.0, color: Colors.black.withOpacity(0.8))
                                          ]
                                      ),
                                      child: AspectRatio(
                                        aspectRatio: 0.8,
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(15.0),
                                          child: Hero(
                                            tag: widget.movie.id,
                                            child: CachedNetworkImage(imageUrl: widget.movie.image, fit: BoxFit.cover,),
                                          ),
                                        ),
                                      ),
                                    ),
                                    builder: (context, widget){
                                      var scale = 1.0;
                                      scale = scale - getPosition() / 200;
                                      if (scale < 0) scale = 0;
                                      var matrix = Matrix4.diagonal3Values(scale, scale, 1.0);
                                      var rotation = 3.14 / 2 - scale * 3.14 / 2;
                                      if (rotation < 0) rotation = 0;
                                      matrix.rotateZ(rotation);
                                      return Transform(
                                        transform: matrix,
                                        alignment: Alignment.center,
                                        child: widget,
                                      );
                                    },
                                  ),
                                ),
                                SizedBox(height: 10.0,),
                                Text(
                                  widget.movie.name,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold,
                                      shadows: [
                                        Shadow(color: Colors.blue.withOpacity(0.9), blurRadius: 10.0)
                                      ]
                                  ),
                                  textDirection: TextDirection.rtl,
                                ),
                                SizedBox(height: 25.0,),
                              ],
                            ),
                          ),
                        ),
                        Transform.translate(
                          offset: Offset(0.0, 30.0),
                          child: IconButton(
                            icon: Icon(Icons.arrow_back_ios, color: Colors.white,),
                            onPressed: (){
                              Navigator.of(context).pop();
                            },
                          ),
                        )
                      ],
                    )
                ),
                Text("فىلىم ھەققىدە:", style: TextStyle(fontSize: 18.0, shadows: [Shadow(color: Colors.white.withOpacity(0.4), blurRadius: 15.0),], fontWeight: FontWeight.bold),),
                Text("ھەلەلەلەلەلپپپ پەلەلەلەلەلەپپپپ فىلىم ھەققىدە.\nشۇنىڭۋىلەن بۇ فىلىمدا بىر توپ قاپاقباشلار مايمۇن ئويناتقىلى ئورمانلىققا بارىدۇ..."),
                Center(
                  child: Container(
                    height: 100.0,
                    width: 350.0,
                    margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(15.0)
                    ),
                    child: Row(
                      children: <Widget>[
                        Flexible(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              _buildKeyValuePair("تەرجىمىدە:", "پالانى"),
                              _buildKeyValuePair("تەھرىر: ", "پۇستانى"),
                              _buildKeyValuePair("كىرىشتۈرگۈچى: ", "ئامانى"),
                            ],
                          ),
                        ),
                        Flexible(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  Text(widget.movie.rate.toString()),
                                  SizedBox(width: 10.0,),
                                  Icon(Icons.star_border, color: Colors.yellow),
                                  Icon(Icons.star_border, color: Colors.yellow),
                                  Icon(Icons.star_half, color: Colors.yellow,),
                                  Icon(Icons.star, color: Colors.yellow),
                                  Icon(Icons.star, color: Colors.yellow),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Icon(Icons.share, color: Colors.yellow, size: 28.0,),
                                  Icon(Icons.thumb_up, color: Colors.yellow, size: 28.0),
                                  Icon(Icons.favorite, color: Colors.yellow, size: 28.0),
                                  Icon(Icons.cloud_download, color: Colors.yellow, size: 28.0),
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Text("مۇناسىۋەتلىك فىلىملەر:"),
                SizedBox(
                  height: 200.0,
                  width: double.infinity,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      MovieView(movie: widget.movie, onTab: (){},),
                      MovieView(movie: widget.movie, onTab: (){},),
                      MovieView(movie: widget.movie, onTab: (){},),
                      MovieView(movie: widget.movie, onTab: (){},),
                      MovieView(movie: widget.movie, onTab: (){},),
                      MovieView(movie: widget.movie, onTab: (){},),
                      MovieView(movie: widget.movie, onTab: (){},),
                      MovieView(movie: widget.movie, onTab: (){},),
                    ],
                  ),
                ),
                Container(
                  height: 200.0,
                )
              ],
            ),
          )
        ],
      )
    );
    buildingWidget = Directionality(
      textDirection: TextDirection.rtl,
      child: buildingWidget,
    );
    return buildingWidget;
  }

  Widget _buildKeyValuePair(String key, String value) {
    var style = TextStyle(
        color: Colors.white.withOpacity(0.4),
      fontSize: 12.0
    );
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(key, style: style,),
        SizedBox(width: 10.0,),
        Spacer(),
        Text(value, style: style,),
        SizedBox(width: 60.0,)
      ],
    );
  }
}

