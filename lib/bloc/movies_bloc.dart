import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_app/data_source/action_movies_data_source.dart';
import 'package:movie_app/data_source/move_details_by_id_data_source.dart';
import 'package:movie_app/data_source/movie_recommendatons_data_source.dart';
import 'package:movie_app/data_source/now_playing_movies_data_source.dart';
import 'package:movie_app/data_source/search_movies_data_source.dart';
import 'package:movie_app/data_source/similar_movies_data_source.dart';
import 'package:movie_app/data_source/trending_movies_data_source.dart';
import 'package:movie_app/model/movie_details_by_id_model.dart';
import 'package:movie_app/model/trending_movies_model.dart';

import '../model/search_movies_model.dart';

part 'movies_event.dart';
part 'movies_state.dart';

class MoviesBloc extends Bloc<MoviesEvent, MoviesState> {
  TrendingMoviesDataSource trendingMoviesDataSource =
      TrendingMoviesDataSource();
  MovieDetailsByIdDataSource movieDetailsByIdDataSource =
      MovieDetailsByIdDataSource();
  MovieRecommendationsDataSource movieRecommendationsDataSource =
      MovieRecommendationsDataSource();
  SearchMoviesDataSource searchMoviesDataSource = SearchMoviesDataSource();
  SimilarMoviesDataSource similarMoviesDataSource = SimilarMoviesDataSource();
  ActionMoviesDataSource actionMoviesDataSource = ActionMoviesDataSource();
  NowPlayingMoviesDataSource nowPlayingMoviesDataSource =
      NowPlayingMoviesDataSource();
  MoviesBloc() : super(MoviesInitial());
  @override
  Stream<MoviesState> mapEventToState(MoviesEvent event) async* {
    if (event is MovieProcess) {
      yield* movieSuccess();
    } else if (event is MovieDetailsByIdProcess) {
      yield* movieDetailsByIdSuccess(event.id!);
    } else if (event is MovieRecommendationsProcess) {
      yield* movieRecommendationsSuccess(event.id);
    } else if (event is SearchMovieProcess) {
      yield* searchMoviesSuccess(event.name);
    } else if (event is SimilarMoviesProcess) {
      yield* similarMoviesSuccess(event.id);
    } else if (event is ActionMoviesProcess) {
      yield* actionMoviesSuccess();
    } else if (event is NowPlayingMoviesProcess) {
      yield* nowPlayingMoviesSuccess();
    }
  }

  Stream<MoviesState> movieSuccess() async* {
    yield MoviesLoading();
    try {
      final dataResponse = await trendingMoviesDataSource.trendingMovies();
      if (dataResponse.isNotEmpty) {
        yield MoviesSuccess(trendingMoviesModel: dataResponse);
      } else {
        yield MoviesFailure();
      }
    } catch (e) {
      yield MoviesFailure();
    }
  }

  Stream<MoviesState> movieDetailsByIdSuccess(int id) async* {
    yield MovieDetailsByIdLoading();
    try {
      final dataResponse =
          await movieDetailsByIdDataSource.movieDetailsById(id);
      if (dataResponse.originalTitle.isNotEmpty) {
        yield MovieDetialsByIdSuccess(movieDetailsByIdModel: dataResponse);
      } else {
        yield MovieDetailsByIdFailure();
      }
    } catch (e) {
      yield MovieDetailsByIdFailure();
    }
  }

  Stream<MoviesState> movieRecommendationsSuccess(int? id) async* {
    yield MovieDetailsByIdLoading();
    try {
      final dataResponse =
          await movieRecommendationsDataSource.movieRecommendations(id);
      if (dataResponse.isNotEmpty) {
        yield MovieRecommendationsSuccess(searchMoviesModel: dataResponse);
      } else {
        yield MovieRecommendationsFailure();
      }
    } catch (e) {
      yield MovieRecommendationsFailure();
    }
  }

  Stream<MoviesState> searchMoviesSuccess(String name) async* {
    yield SearchMoviesLoading();
    try {
      final dataResponse = await searchMoviesDataSource.searchMovies(name);
      if (dataResponse.isNotEmpty) {
        yield SearchMoviesSuccess(searchMoviesModel: dataResponse);
      } else {
        yield SearchMoviesFailure();
      }
    } catch (e) {
      yield SearchMoviesFailure();
    }
  }

  Stream<MoviesState> similarMoviesSuccess(int? id) async* {
    yield SimilarMoviesLoading();
    try {
      final dataResponse = await similarMoviesDataSource.similarMovies(id);
      if (dataResponse.isNotEmpty) {
        yield SimilarMoviesSuccess(similarMoviesModel: dataResponse);
      } else {
        yield SimilarMoviesFailure();
      }
    } catch (e) {
      yield SimilarMoviesFailure();
    }
  }

  Stream<MoviesState> actionMoviesSuccess() async* {
    yield ActionMoviesLoading();
    try {
      final dataResponse = await actionMoviesDataSource.actionMovies();
      if (dataResponse.isNotEmpty) {
        yield ActionMoviesSuccess(actionMoviesModel: dataResponse);
      } else {
        yield ActionMoviesFailure();
      }
    } catch (e) {
      yield ActionMoviesFailure();
    }
  }

  Stream<MoviesState> nowPlayingMoviesSuccess() async* {
    yield NowPlayingMoviesLoading();
    try {
      final dataResponse = await nowPlayingMoviesDataSource.nowPlayingmovies();
      if (dataResponse.isNotEmpty) {
        yield NowPlayingMoviesSuccess(nowPlayingMoviesModel: dataResponse);
      } else {
        yield NowPlayingMoviesFailure();
      }
    } catch (e) {
      yield NowPlayingMoviesFailure();
    }
  }
}
