import 'package:dio/dio.dart';
import 'package:movie_app/data_source/api_client.dart';
import 'package:movie_app/model/trending_movies_model.dart';

class TrendingMoviesDataSource {
  final Dio client = ApiClient().dio;
  Future<List<TrendingMovies>> trendingMovies() async {
    List<TrendingMovies> trendingMoviesModel = [];
    final response = await client.get(
        'https://api.themoviedb.org/3/trending/movie/week?api_key=a9925cf17982b80b6fa31618a0ff8a32',
        options: Options(headers: {
          'content-type': 'application/json',
        }));
    try {
      final results = response.data['results'] as List?;
      if (results != null) {
        for (var element in results) {
          try {
            trendingMoviesModel.add(TrendingMovies.fromJson(element));
          } catch (_) {}
        }
      }
    } catch (e) {
      // ignore
    }

    print(trendingMoviesModel);
    return trendingMoviesModel;
  }
}
