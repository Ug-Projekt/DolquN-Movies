import 'package:dolqun_movies/Entities/Movie.dart';
import 'package:dolqun_movies/Interface/Network.dart';
import 'package:dolqun_movies/StateManagement/ModelProvider.dart';

class HomePageModel extends Model {
  MoviesResponse homeList;
  final NetworkInterface api;

  HomePageModel(this.api);

  Future<bool> initialize() async {
    this.homeList = await this.api.getHomeList();
    this.applyChanges();
    return true;
  }
  Future<bool> initializationResult;
}
