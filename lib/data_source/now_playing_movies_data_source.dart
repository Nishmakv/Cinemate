import 'package:dio/dio.dart';
import 'package:movie_app/data_source/api_client.dart';
import 'package:movie_app/model/search_movies_model.dart';

class NowPlayingMoviesDataSource {
  final Dio client = ApiClient().dio;
  Future<List<MovieSearchModel>> nowPlayingmovies() async {
    List<MovieSearchModel> nowPlayingMoviesModel = [];
    final respose = await client.get(
        'https://api.themoviedb.org/3/movie/now_playing?api_key=a9925cf17982b80b6fa31618a0ff8a32&language=en-US',
        options: Options(headers: {
          'content-type': 'application/json',
        }));
    final results = respose.data['results'] as List?;
    if (results != null) {
      for (var element in results) {
        try {
          nowPlayingMoviesModel.add(MovieSearchModel.fromJson(element));
        } catch (_) {}
      }
    }
    return nowPlayingMoviesModel;
  }
}
