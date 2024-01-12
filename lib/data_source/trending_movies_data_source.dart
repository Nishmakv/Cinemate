import 'package:dio/dio.dart';
import 'package:movie_app/model/trending_movies_model.dart';

class TrendingMoviesDataSource {
  Dio client = Dio();
  Future<List<TrendingMovies>> trendingMovies() async {
    List<TrendingMovies> trendingMoviesModel = [];
    final response = await client.get(
        'https://api.themoviedb.org/3/trending/movie/week?api_key=a9925cf17982b80b6fa31618a0ff8a32',
        options: Options(headers: {
          'content-type': 'application/json',
        }));
    try {
      (response.data['results'] as List).forEach((element) {
        trendingMoviesModel.add(TrendingMovies.fromJson(element));
      });
    } catch (e) {
      print(e);
    }

    print(trendingMoviesModel);
    return trendingMoviesModel;
  }
}
