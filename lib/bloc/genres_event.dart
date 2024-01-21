part of 'genres_bloc.dart';

sealed class GenresEvent extends Equatable {
  const GenresEvent();

  @override
  List<Object> get props => [];
}

// ignore: must_be_immutable
class GenresActionProcess extends GenresEvent {
  int? id;
  GenresActionProcess({required this.id});
}

// ignore: must_be_immutable
class AnimationMoviesProcess extends GenresEvent {
  int? id;
  AnimationMoviesProcess({required this.id});
}

// ignore: must_be_immutable
class ComedyMoviesProcess extends GenresEvent {
  int? id;
  ComedyMoviesProcess({required this.id});
}

// ignore: must_be_immutable
class RomanticMoviesProcess extends GenresEvent {
  int? id;
  RomanticMoviesProcess({required this.id});
}

// ignore: must_be_immutable
class ThrillerMoviesProcess extends GenresEvent {
  int? id;
  ThrillerMoviesProcess({required this.id});
}

// ignore: must_be_immutable
class HorrorMoviesProcess extends GenresEvent {
  int? id;
  HorrorMoviesProcess({required this.id});
}

class TopRatedMoviesProcess extends GenresEvent {
  const TopRatedMoviesProcess();
}
