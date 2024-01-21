import 'package:dio/dio.dart';
import 'package:movie_app/model/search_movies_model.dart';

class GenresMoviesDataSource {
  Dio client = Dio();
  Future<List<MovieSearchModel>> actionMovies(int? id) async {
    List<MovieSearchModel> actionMoviesModel = [];

    final response = await client.get(
        'https://api.themoviedb.org/3/discover/movie?api_key=a9925cf17982b80b6fa31618a0ff8a32&with_genres=${id.toString()}',
        options: Options(headers: {
          'content-type': 'application/json',
        }));
    print(response);
    (response.data['results'] as List).forEach((element) {
      actionMoviesModel.add(MovieSearchModel.fromJson(element));
    });

    return actionMoviesModel;
  }
}
