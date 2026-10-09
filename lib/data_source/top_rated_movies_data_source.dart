import 'package:dio/dio.dart';
import 'package:movie_app/data_source/api_client.dart';
import 'package:movie_app/model/search_movies_model.dart';

class TopRatedMoviesDataSource {
  final Dio client = ApiClient().dio;
  Future<List<MovieSearchModel>> topRatedMovies() async {
    List<MovieSearchModel> topRatedMoviesModel = [];
    final response = await client.get(
        'https://api.themoviedb.org/3/movie/top_rated?language=en-US&page=1&api_key=a9925cf17982b80b6fa31618a0ff8a32',
        options: Options(headers: {
          'content-type': 'application/json',
        }));
    final results = response.data['results'] as List?;
    if (results != null) {
      for (var element in results) {
        try {
          topRatedMoviesModel.add(MovieSearchModel.fromJson(element));
        } catch (_) {}
      }
    }
    return topRatedMoviesModel;
  }
}
