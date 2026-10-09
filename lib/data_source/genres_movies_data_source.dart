import 'package:dio/dio.dart';
import 'package:movie_app/data_source/api_client.dart';
import 'package:movie_app/model/search_movies_model.dart';

class GenresMoviesDataSource {
  final Dio client = ApiClient().dio;
  Future<List<MovieSearchModel>> actionMovies(int? id) async {
    List<MovieSearchModel> actionMoviesModel = [];

    final response = await client.get(
        'https://api.themoviedb.org/3/discover/movie?api_key=a9925cf17982b80b6fa31618a0ff8a32&with_genres=${id.toString()}',
        options: Options(headers: {
          'content-type': 'application/json',
        }));
    final results = response.data['results'] as List?;
    if (results != null) {
      for (var element in results) {
        try {
          actionMoviesModel.add(MovieSearchModel.fromJson(element));
        } catch (_) {}
      }
    }

    return actionMoviesModel;
  }
}
