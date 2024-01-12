import 'package:dio/dio.dart';
import 'package:movie_app/model/search_movies_model.dart';

class SimilarMoviesDataSource {
  Dio client = Dio();
  Future<List<MovieSearchModel>> similarMovies(int? id) async {
    List<MovieSearchModel> similarMoviesModel = [];
    final response = await client.get(
        'https://api.themoviedb.org/3/movie/${id.toString()}/similar?api_key=a9925cf17982b80b6fa31618a0ff8a32&language=en-US&page=1',
        options: Options(headers: {'content-type': 'application/json'}));
    print(response);
    (response.data['results'] as List).forEach((element) {
      similarMoviesModel.add(MovieSearchModel.fromJson(element));
    });
    return similarMoviesModel;
  }
}
