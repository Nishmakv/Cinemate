import 'package:dio/dio.dart';
import 'package:movie_app/model/search_movies_model.dart';

class NowPlayingMoviesDataSource {
  Dio client = Dio();
  Future<List<MovieSearchModel>> nowPlayingmovies() async {
    List<MovieSearchModel> nowPlayingMoviesModel = [];
    final respose = await client.get(
        'https://api.themoviedb.org/3/movie/now_playing?api_key=a9925cf17982b80b6fa31618a0ff8a32&language=en-US',
        options: Options(headers: {
          'content-type': 'application/json',
        }));
    (respose.data['results'] as List).forEach((element) {
      nowPlayingMoviesModel.add(MovieSearchModel.fromJson(element));
    });
    return nowPlayingMoviesModel;
  }
}
