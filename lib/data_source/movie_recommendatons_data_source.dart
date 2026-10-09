import 'package:dio/dio.dart';
import 'package:movie_app/data_source/api_client.dart';
import 'package:movie_app/model/search_movies_model.dart';

class MovieRecommendationsDataSource {
  final Dio client = ApiClient().dio;
  Future<List<MovieSearchModel>> movieRecommendations(int? id) async {
    List<MovieSearchModel> movieRecommendations = [];
    final response = await client.get(
        'https://api.themoviedb.org/3/movie/${id.toString()}/recommendations?api_key=a9925cf17982b80b6fa31618a0ff8a32&language=en-US&page=1');
    print(response);
    (response.data['results'] as List).forEach((element) {
      movieRecommendations.add(MovieSearchModel.fromJson(element));
    });
    return movieRecommendations;
  }
}
