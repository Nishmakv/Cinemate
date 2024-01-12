import 'package:dio/dio.dart';
import 'package:movie_app/model/search_movies_model.dart';

class SearchMoviesDataSource {
  Dio client = Dio();
  Future<List<MovieSearchModel>> searchMovies(String? name) async {
    List<MovieSearchModel> searchMoviesModel = [];
    final response = await client.get(
        'https://api.themoviedb.org/3/search/movie?api_key=a9925cf17982b80b6fa31618a0ff8a32&language=en-US&page=1&include_adult=false&query=${name}',
        options: Options(headers: {'content-type': 'application/json'}));
    print(response);

    (response.data['results'] as List).forEach((element) {
      searchMoviesModel.add(MovieSearchModel.fromJson(element));
    });
    return searchMoviesModel;
  }
}
