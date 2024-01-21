part of 'genres_bloc.dart';

abstract class GenresState extends Equatable {
  const GenresState();

  @override
  List<Object> get props => [];
}

final class GenresActionInitial extends GenresState {}

final class GenresActionLoading extends GenresState {}

// ignore: must_be_immutable
final class GenresActionSuccess extends GenresState {
  List<MovieSearchModel> actionMoviesModel = [];
  GenresActionSuccess({required this.actionMoviesModel});
}

final class GenresActionFailure extends GenresState {}

final class AnimationMoviesInitial extends GenresState {}

final class AnimationMoviesLoading extends GenresState {}

// ignore: must_be_immutable
final class AnimationMoviesSuccess extends GenresState {
  List<MovieSearchModel> animationMoviesModel = [];
  AnimationMoviesSuccess({required this.animationMoviesModel});
}

final class AnimationMoviesFailure extends GenresState {}

final class ComedyMoviesInitial extends GenresState {}

final class ComedyMoviesLoading extends GenresState {}

// ignore: must_be_immutable
final class ComedyMoviesSuccess extends GenresState {
  List<MovieSearchModel> comedyMoviesModel = [];
  ComedyMoviesSuccess({required this.comedyMoviesModel});
}

final class ComedyMoviesFailure extends GenresState {}

final class RomanticMoviesInitial extends GenresState {}

final class RomanticMoviesLoading extends GenresState {}

// ignore: must_be_immutable
final class RomanticMoviesSuccess extends GenresState {
  List<MovieSearchModel> romanticMoviesModel = [];
  RomanticMoviesSuccess({required this.romanticMoviesModel});
}

final class RomanticMoviesFailure extends GenresState {}

final class ThrillerMoviesInitial extends GenresState {}

final class ThrillerMoviesLoading extends GenresState {}

// ignore: must_be_immutable
final class ThrillerMoviesSuccess extends GenresState {
  List<MovieSearchModel> thrillerMoviesModel = [];
  ThrillerMoviesSuccess({required this.thrillerMoviesModel});
}

final class ThrillerMoviesFailure extends GenresState {}

final class HorrorMoviesInitial extends GenresState {}

final class HorrorMoviesLoading extends GenresState {}

// ignore: must_be_immutable
final class HorrorMoviesSuccess extends GenresState {
  List<MovieSearchModel> horrorMoviesModel = [];
  HorrorMoviesSuccess({required this.horrorMoviesModel});
}

final class HorrorMoviesFailure extends GenresState {}

final class TopRatedMoviesInitial extends GenresState {}

final class TopRatedMoviesLoading extends GenresState {}

// ignore: must_be_immutable
final class TopRatedMoviesSuccess extends GenresState {
  List<MovieSearchModel> topRatedMoviesModel = [];
  TopRatedMoviesSuccess({required this.topRatedMoviesModel});
}

final class TopratedMoviesFailure extends GenresState {}
