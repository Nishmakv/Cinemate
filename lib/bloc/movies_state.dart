part of 'movies_bloc.dart';

sealed class MoviesState extends Equatable {
  const MoviesState();

  @override
  List<Object> get props => [];
}

final class MoviesInitial extends MoviesState {}

final class MoviesLoading extends MoviesState {}

// ignore: must_be_immutable
final class MoviesSuccess extends MoviesState {
  List<TrendingMovies> trendingMoviesModel = [];
  MoviesSuccess({required this.trendingMoviesModel});
}

final class MoviesFailure extends MoviesState {}

final class MovieDetailsByIdInitial extends MoviesState {}

final class MovieDetailsByIdLoading extends MoviesState {}

// ignore: must_be_immutable
final class MovieDetialsByIdSuccess extends MoviesState {
  MovieDetailsById? movieDetailsByIdModel;
  MovieDetialsByIdSuccess({required this.movieDetailsByIdModel});
}

final class MovieDetailsByIdFailure extends MoviesState {}

final class MovieRecommendationsInitial extends MoviesState {}

final class MovieRecommendationsLoading extends MoviesState {}

// ignore: must_be_immutable
final class MovieRecommendationsSuccess extends MoviesState {
  List<MovieSearchModel> movieRecommendations = [];
  MovieRecommendationsSuccess({required this.movieRecommendations});
}

final class MovieRecommendationsFailure extends MoviesState {}

final class SearchMoviesInitial extends MoviesState {}

final class SearchMoviesLoading extends MoviesState {}

// ignore: must_be_immutable
final class SearchMoviesSuccess extends MoviesState {
  List<MovieSearchModel> searchMoviesModel = [];
  SearchMoviesSuccess({required this.searchMoviesModel});
}

final class SearchMoviesFailure extends MoviesState {}

final class SimilarMoviesInitial extends MoviesState {}

final class SimilarMoviesLoading extends MoviesState {}

// ignore: must_be_immutable
final class SimilarMoviesSuccess extends MoviesState {
  List<MovieSearchModel> similarMoviesModel = [];
  SimilarMoviesSuccess({required this.similarMoviesModel});
}

final class SimilarMoviesFailure extends MoviesState {}

final class NowPlayingMoviesInitial extends MoviesState {}

final class NowPlayingMoviesLoading extends MoviesState {}

// ignore: must_be_immutable
final class NowPlayingMoviesSuccess extends MoviesState {
  List<MovieSearchModel> nowPlayingMoviesModel = [];
  NowPlayingMoviesSuccess({required this.nowPlayingMoviesModel});
}

final class NowPlayingMoviesFailure extends MoviesState {}

final class AnimationMoviesInitial extends MoviesState {}

final class AnimationMoviesLoading extends MoviesState {}
