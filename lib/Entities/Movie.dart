/*
Auto generated code by https://github.com/javiercbk/json_to_dart
this project cloned to https://gitee.com/yeganaaa/Json2Dart-Generator by yeganaaa@163.com
Thank you https://github.com/javiercbk/json_to_dart
*/


import 'package:dolqun_movies/StateManagement/ModelProvider.dart';

class MoviesResponse {
  int code;
  List<MovieCategory> data;
  String msg;

  MoviesResponse({this.code, this.data, this.msg});

  MoviesResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    if (json['data'] != null) {
      data = new List<MovieCategory>();
      json['data'].forEach((v) {
        data.add(new MovieCategory.fromJson(v));
      });
    }
    msg = json['msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    data['msg'] = this.msg;
    return data;
  }
}

class MovieCategory {
  String image;
  String name;
  int id;
  int sort;
  List<Movie> items;

  MovieCategory({this.image, this.name, this.id, this.sort, this.items});

  MovieCategory.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    name = json['name'];
    id = json['id'];
    sort = json['sort'];
    if (json['items'] != null) {
      items = new List<Movie>();
      json['items'].forEach((v) {
        items.add(new Movie.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image'] = this.image;
    data['name'] = this.name;
    data['id'] = this.id;
    data['sort'] = this.sort;
    if (this.items != null) {
      data['items'] = this.items.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Movie {
  int episode;
  int recommend;
  int mode;
  double rate;
  int id;
  String summary;
  String image;
  int sort;
  String name;
  int totalepisode;

  Movie(
      {this.episode,
        this.recommend,
        this.mode,
        this.rate,
        this.id,
        this.summary,
        this.image,
        this.sort,
        this.name,
        this.totalepisode});

  Movie.fromJson(Map<String, dynamic> json) {
    episode = json['episode'];
    recommend = json['recommend'];
    mode = json['mode'];
    rate = (json['rate'] as num).toDouble();
    id = json['id'];
    summary = json['summary'];
    image = json['image'];
    sort = json['sort'];
    name = json['name'];
    totalepisode = json['totalepisode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['episode'] = this.episode;
    data['recommend'] = this.recommend;
    data['mode'] = this.mode;
    data['rate'] = this.rate;
    data['id'] = this.id;
    data['summary'] = this.summary;
    data['image'] = this.image;
    data['sort'] = this.sort;
    data['name'] = this.name;
    data['totalepisode'] = this.totalepisode;
    return data;
  }
}
