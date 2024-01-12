// To parse this JSON data, do
//
//     final movieSearchModel = movieSearchModelFromJson(jsonString);

import 'dart:convert';

MovieSearchModel movieSearchModelFromJson(String str) =>
    MovieSearchModel.fromJson(json.decode(str));

String movieSearchModelToJson(MovieSearchModel data) =>
    json.encode(data.toJson());

class MovieSearchModel {
  int? id;
  String? posterPath;
  double? voteAverage;
   String? backdropPath;

  MovieSearchModel({
    this.id,
    this.posterPath,
    this.voteAverage,
    this.backdropPath,
  });

  factory MovieSearchModel.fromJson(Map<String, dynamic> json) =>
      MovieSearchModel(
        id: json["id"],
        posterPath: json["poster_path"],
        voteAverage: json["vote_average"]?.toDouble(),
           backdropPath: json["backdrop_path"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "poster_path": posterPath,
        "vote_average": voteAverage,
         "backdrop_path": backdropPath,
      };
}
