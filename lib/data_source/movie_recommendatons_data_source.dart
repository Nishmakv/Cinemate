import 'package:dio/dio.dart';
import 'package:movie_app/model/search_movies_model.dart';

class MovieRecommendationsDataSource {
  Dio client = Dio();
  Future<List<MovieSearchModel>> movieRecommendations(int? id) async {
    List<MovieSearchModel> movieRecommendations = [];
    final response = await client.get(
        'https://api.themoviedb.org/3/movie/${id.toString()}/recommendations?api_key=a9925cf17982b80b6fa31618a0ff8a32&language=en-US&page=1',
        options: Options(headers: {'content_type': 'aapplication/json'}));
    print(response);
    (response.data['results'] as List).forEach((element) {
      movieRecommendations.add(element);
    });
    return movieRecommendations;
  }
}
