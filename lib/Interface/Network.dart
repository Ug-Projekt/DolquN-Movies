

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dolqun_movies/Entities/Movie.dart';
import 'package:dolqun_movies/StateManagement/ModelProvider.dart';

class NetworkInterface with Model {
  Dio _dio;

  NetworkInterface({String url}) {
    this._dio = Dio(BaseOptions(
      baseUrl: url,
    ));
  }

  Future<MoviesResponse> getHomeList() async {
    var response = await _dio.get<String>("/2.0/API.do?action=home_list");
    var data = MoviesResponse.fromJson(json.decode(response.data));
    return data;
  }
}
