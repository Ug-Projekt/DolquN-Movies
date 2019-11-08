
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dolqun_movies/StateManagement/ModelProvider.dart';
import 'package:dolqun_movies/UI/Pages/Models/HomePageModel.dart';
import 'package:dolqun_movies/UI/Widgets/MovieView.dart';
import 'package:dolqun_movies/UI/Widgets/MyEdgeClipper.dart';
import 'package:flutter/material.dart';

import 'Models/AnimationKeysModel.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    var keyModel = ModelContainer.of<AnimationKeysModel>(context).model;

    var keyOfParent = keyModel.settingsIconKeys[0].keyOfParent;
    keyModel.shareIconKeys[0].keyOfParent = keyOfParent;
    keyModel.cartIconKeys[0].keyOfParent = keyOfParent;
    keyModel.favoriteIconKeys[0].keyOfParent = keyOfParent;

    Widget buildingWidget = Scaffold(
      key: keyOfParent,
      backgroundColor: Colors.transparent,
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            backgroundColor: Colors.transparent,
            expandedHeight: 290.0,
            flexibleSpace: FlexibleSpaceBar(
              background: ClipPath(
                clipper: MyEdgeClipper(
                  clipHeight: 25.0
                ),
                child: Stack(
                  children: <Widget>[
                    Positioned.fill(
                      child: CachedNetworkImage(imageUrl: "https://cdn.pixabay.com/photo/2016/10/21/14/50/plouzane-1758197_960_720.jpg", fit: BoxFit.cover,),
                    ),
                    Positioned(
                      top: 0.0,
                      bottom: 0.0,
                      right: 0.0,
                      width: 40.0,
                      child: Center(
                        child: SizedBox(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Container(
                                decoration: BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20.0),
                                      bottomLeft: Radius.circular(20.0),
                                    )
                                ),
                                height: 80.0,
                                width: double.infinity,
                                child: Icon(Icons.settings, color: Colors.white,),
                              ),
                              SizedBox(height: 50.0,),
                              Container(
                                decoration: BoxDecoration(
                                    color: Colors.orange,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20.0),
                                      bottomLeft: Radius.circular(20.0),
                                    )
                                ),
                                height: 80.0,
                                width: double.infinity,
                                child: Icon(Icons.email, color: Colors.white,),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned.fill(
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            CircleAvatar(
                              radius: 60.0,
                              backgroundImage: NetworkImage("https://cdn.pixabay.com/photo/2016/10/07/08/56/beauty-1721060_960_720.jpg"),
                            ),
                            RaisedButton(
                              child: Text("كىشىڭ"),
                              onPressed: (){},
                            ),
                            SizedBox(height: 50.0,)
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              Text("كۆرۈش خاتېرىسى", style: TextStyle(color: Colors.blue),),
              SizedBox(height: 30.0,),
              SizedBox(
                height: 200.0,
                child: Stack(
                  children: <Widget>[
                    Positioned.fill(
                      child: ModelDescendant<HomePageModel>(
                        onChanged: (context, _, model) => ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            SizedBox(width: 60.0,),
                            ...model.homeList.data[0].items.map((item) => MovieView(
                              movie: item,
                              onTab: (){

                              },
                            )).toList(),
                            SizedBox(width: 60.0,),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      top: 0,
                      bottom: 0,
                      right: 0,
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(25.0),
                          bottomLeft: Radius.circular(25.0),
                        ),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaY: 10.0, sigmaX: 10.0),
                          child: Container(
                            width: 50.0,
                            height: double.infinity,
                            color: Colors.white.withOpacity(0.04),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                Container(width: 10.0, height: 10.0, color: Colors.transparent, key: keyModel.favoriteIconKeys[0].keyOfWidget,),
                                Container(width: 10.0, height: 10.0, color: Colors.transparent, key: keyModel.shareIconKeys[0].keyOfWidget,),
                                Container(width: 10.0, height: 10.0, color: Colors.transparent, key: keyModel.cartIconKeys[0].keyOfWidget,),
                                Container(width: 10.0, height: 10.0, color: Colors.transparent, key: keyModel.settingsIconKeys[0].keyOfWidget,),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ]),
          )
        ],
      ),
    );
    return buildingWidget;
  }
}
