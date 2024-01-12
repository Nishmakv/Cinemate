import 'package:dio/dio.dart';
import 'package:movie_app/model/movie_details_by_id_model.dart';

class MovieDetailsByIdDataSource {
  Dio client = Dio();
  Future movieDetailsById(int? id) async {
    MovieDetailsById movieDetailsByIdModel;
    final response = await client.get(
        'https://api.themoviedb.org/3/movie/${id.toString()}?api_key=a9925cf17982b80b6fa31618a0ff8a32&language=en-US',
        options: Options(headers: {
          'content-type': 'application/json',
        }));

   
    try {
      movieDetailsByIdModel = MovieDetailsById.fromJson(response.data);
      
      return movieDetailsByIdModel;
    } catch (e) {
      print(e);
    }
  }
}
