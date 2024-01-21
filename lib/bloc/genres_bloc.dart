import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_app/data_source/genres_movies_data_source.dart';
import 'package:movie_app/data_source/top_rated_movies_data_source.dart';
import 'package:movie_app/model/search_movies_model.dart';

part 'genres_event.dart';
part 'genres_state.dart';

class GenresBloc extends Bloc<GenresEvent, GenresState> {
  GenresMoviesDataSource genresMoviesDataSource = GenresMoviesDataSource();
  TopRatedMoviesDataSource topRatedMoviesDataSource =
      TopRatedMoviesDataSource();
  GenresBloc() : super(GenresActionInitial());
  @override
  Stream<GenresState> mapEventToState(GenresEvent event) async* {
    if (event is GenresActionProcess) {
      yield* genresActionSuccess(event.id);
    } else if (event is AnimationMoviesProcess) {
      yield* animationMoviesSuccess(event.id);
    } else if (event is ComedyMoviesProcess) {
      yield* comedyMoviesSuccess(event.id);
    } else if (event is RomanticMoviesProcess) {
      yield* romanticMoviesSuccess(event.id);
    } else if (event is ThrillerMoviesProcess) {
      yield* thrillerMoviesSuccess(event.id);
    } else if (event is HorrorMoviesProcess) {
      yield* horrorMoviesSuccess(event.id);
    } else if (event is TopRatedMoviesProcess) {
      yield* topRatedMoviesSuccess();
    }
  }

  Stream<GenresState> genresActionSuccess(int? id) async* {
    yield GenresActionLoading();
    try {
      final dataResponse = await genresMoviesDataSource.actionMovies(id);
      if (dataResponse.isNotEmpty) {
        yield GenresActionSuccess(actionMoviesModel: dataResponse);
      } else {
        yield GenresActionFailure();
      }
    } catch (e) {
      yield GenresActionFailure();
    }
  }

  Stream<GenresState> animationMoviesSuccess(int? id) async* {
    yield AnimationMoviesLoading();
    try {
      final dataResponse = await genresMoviesDataSource.actionMovies(16);
      if (dataResponse.isNotEmpty) {
        yield AnimationMoviesSuccess(animationMoviesModel: dataResponse);
      } else {
        yield AnimationMoviesFailure();
      }
    } catch (e) {
      yield AnimationMoviesFailure();
    }
  }

  Stream<GenresState> comedyMoviesSuccess(int? id) async* {
    yield ComedyMoviesLoading();
    try {
      final dataResponse = await genresMoviesDataSource.actionMovies(id);
      if (dataResponse.isNotEmpty) {
        yield ComedyMoviesSuccess(comedyMoviesModel: dataResponse);
      } else {
        yield ComedyMoviesFailure();
      }
    } catch (e) {
      yield ComedyMoviesFailure();
    }
  }

  Stream<GenresState> romanticMoviesSuccess(int? id) async* {
    yield RomanticMoviesLoading();
    try {
      final dataResponse = await genresMoviesDataSource.actionMovies(id);
      if (dataResponse.isNotEmpty) {
        yield RomanticMoviesSuccess(romanticMoviesModel: dataResponse);
      } else {
        yield RomanticMoviesFailure();
      }
    } catch (e) {
      yield RomanticMoviesFailure();
    }
  }

  Stream<GenresState> thrillerMoviesSuccess(int? id) async* {
    yield ThrillerMoviesLoading();
    try {
      final dataResponse = await genresMoviesDataSource.actionMovies(id);
      if (dataResponse.isNotEmpty) {
        yield ThrillerMoviesSuccess(thrillerMoviesModel: dataResponse);
      } else {
        yield ThrillerMoviesFailure();
      }
    } catch (e) {
      yield ThrillerMoviesFailure();
    }
  }

  Stream<GenresState> horrorMoviesSuccess(int? id) async* {
    yield ThrillerMoviesLoading();
    try {
      final dataResponse = await genresMoviesDataSource.actionMovies(id);
      if (dataResponse.isNotEmpty) {
        yield HorrorMoviesSuccess(horrorMoviesModel: dataResponse);
      } else {
        yield HorrorMoviesFailure();
      }
    } catch (e) {
      yield HorrorMoviesFailure();
    }
  }

  Stream<GenresState> topRatedMoviesSuccess() async* {
    yield TopRatedMoviesLoading();
    try {
      final dataResponse = await topRatedMoviesDataSource.topRatedMovies();
      if (dataResponse.isNotEmpty) {
        yield TopRatedMoviesSuccess(topRatedMoviesModel: dataResponse);
      } else {
        yield TopratedMoviesFailure();
      }
    } catch (e) {
      yield TopratedMoviesFailure();
    }
  }
}
