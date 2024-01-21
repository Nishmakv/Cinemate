import 'package:dio/dio.dart';
import 'package:movie_app/model/search_movies_model.dart';

class TopRatedMoviesDataSource {
  Dio client = Dio();
  Future<List<MovieSearchModel>> topRatedMovies() async {
    List<MovieSearchModel> topRatedMoviesModel = [];
    final response = await client.get(
        'https://api.themoviedb.org/3/movie/top_rated?language=en-US&page=1&api_key=a9925cf17982b80b6fa31618a0ff8a32',
        options: Options(headers: {
          'content-type': 'application/json',
        }));
    (response.data['results'] as List).forEach((element) {
      topRatedMoviesModel.add(MovieSearchModel.fromJson(element));
    });
    return topRatedMoviesModel;
  }
}
