part of 'movies_bloc.dart';

sealed class MoviesEvent extends Equatable {
  const MoviesEvent();

  @override
  List<Object> get props => [];
}

class MovieProcess extends MoviesEvent {
  const MovieProcess();
}

// ignore: must_be_immutable
class MovieDetailsByIdProcess extends MoviesEvent {
  int? id;
  MovieDetailsByIdProcess({required this.id});
}

// ignore: must_be_immutable
class MovieRecommendationsProcess extends MoviesEvent {
  int? id;
  MovieRecommendationsProcess({required this.id});
}

class SearchMovieProcess extends MoviesEvent {
  final String name;
  const SearchMovieProcess({required this.name});
}

// ignore: must_be_immutable
class SimilarMoviesProcess extends MoviesEvent {
  int? id;
  SimilarMoviesProcess({required this.id});
}

class NowPlayingMoviesProcess extends MoviesEvent {
  const NowPlayingMoviesProcess();
}
