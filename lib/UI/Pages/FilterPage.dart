

import 'package:dolqun_movies/StateManagement/ModelProvider.dart';
import 'package:flutter/material.dart';

import 'Models/AnimationKeysModel.dart';

class FilterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var keyModel = ModelContainer.of<AnimationKeysModel>(context).model;
    var keyOfContainer = keyModel.searchIconKeys[2].keyOfParent;
    keyModel.favoriteIconKeys[2].keyOfParent = keyOfContainer;
    keyModel.cartIconKeys[2].keyOfParent = keyOfContainer;
    keyModel.accountIconKeys[2].keyOfParent = keyOfContainer;

//    keyModel.settingsIconKeys[2].keyOfParent = keyModel.shareIconKeys[2].keyOfParent = keyOfContainer;

    Widget buildingWidget = Stack(
      children: <Widget>[
        Positioned.fill(
          child: Padding(
            padding: EdgeInsets.all(50.0),
            child: Column(
//              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("DolquN movies app", style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),),
                SizedBox(height: 20.0,),
                Text("Welcome to my github (or gitEE) repository."),
                SizedBox(height: 10.0,),
                Text("for source code please search 'yeganaaa' for user name or 'DolquN-Movies' for repository name in github (Or GitEE in china.)", textAlign: TextAlign.center,),
              ],
            )
            ,
          ),
        ),
        Positioned(
          left: 0.0,
          top: 0.0,
          bottom: 0.0,
          width: 50.0,
          child: Center(
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(20.0),
                bottomRight: Radius.circular(20.0),
              ),
              child: Container(
                constraints: BoxConstraints(
                    maxHeight: 250.0,
                    minHeight: 100.0
                ),
                width: double.infinity,
                padding: EdgeInsets.all(10.0),
                color: Colors.white.withOpacity(0.04),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    SizedBox(width: 10.0, height: 10.0, key: keyModel.accountIconKeys[2].keyOfWidget,),
                    SizedBox(width: 10.0, height: 10.0, key: keyModel.searchIconKeys[2].keyOfWidget,),
                    SizedBox(width: 10.0, height: 10.0, key: keyModel.cartIconKeys[2].keyOfWidget,),
                    SizedBox(width: 10.0, height: 10.0, key: keyModel.favoriteIconKeys[2].keyOfWidget,),
                  ],
                ),
              ),
            ),
          ),
        )
      ],
    );
    buildingWidget = Scaffold(
      key: keyOfContainer,
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.white.withOpacity(0.04),
        title: Text("Filter page"),
      ),
      body: buildingWidget,
    );
    return buildingWidget;
  }
}