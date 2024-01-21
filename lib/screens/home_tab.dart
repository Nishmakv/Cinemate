import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/bloc/genres_bloc.dart';
import 'package:movie_app/bloc/movies_bloc.dart';
import 'package:movie_app/model/search_movies_model.dart';
import 'package:movie_app/model/trending_movies_model.dart';
import 'package:movie_app/screens/movie_detail_screen.dart';
import 'package:movie_app/widgets/movie_list.dart';
import 'package:movie_app/widgets/movie_list_shimmer.dart';
import 'package:shimmer/shimmer.dart';

// ignore: must_be_immutable
class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  List<TrendingMovies> trendingMoviesModel = [];
  List<MovieSearchModel> actionMoviesModel = [];
  List<MovieSearchModel> nowPlayingMoviesModel = [];
  List<MovieSearchModel> animationMoviesModel = [];
  List<MovieSearchModel> comedyMoviesModel = [];
  List<MovieSearchModel> romanticMoviesModel = [];
  List<MovieSearchModel> thrillerMoviesModel = [];
  List<MovieSearchModel> horrorMoviesModel = [];
  List<MovieSearchModel> topRatedMoviesModel = [];
  @override
  void initState() {
    super.initState();

    context.read<MoviesBloc>().add(
          const MovieProcess(),
        );
    context.read<GenresBloc>().add(
          GenresActionProcess(id: 28),
        );
    context.read<GenresBloc>().add(
          AnimationMoviesProcess(id: 16),
        );
    context.read<GenresBloc>().add(
          ComedyMoviesProcess(id: 35),
        );
    context.read<GenresBloc>().add(
          RomanticMoviesProcess(id: 10749),
        );
    context.read<GenresBloc>().add(
          ThrillerMoviesProcess(id: 53),
        );
    context.read<GenresBloc>().add(
          HorrorMoviesProcess(id: 27),
        );

    context.read<MoviesBloc>().add(
          const NowPlayingMoviesProcess(),
        );
    context.read<GenresBloc>().add(
          const TopRatedMoviesProcess(),
        );
  }

  @override
  Widget build(BuildContext context) {
    final double w = MediaQuery.of(context).size.width;
    final double h = MediaQuery.of(context).size.height;
    return MultiBlocListener(
      listeners: [
        BlocListener<MoviesBloc, MoviesState>(
          listener: (context, state) {
            if (state is MoviesSuccess) {
              trendingMoviesModel.addAll(state.trendingMoviesModel);
              setState(() {});
            }
          },
        ),
        BlocListener<GenresBloc, GenresState>(
          listener: (context, state) {
            if (state is GenresActionSuccess) {
              actionMoviesModel.addAll(state.actionMoviesModel);
              setState(() {});
            }
          },
        ),
        BlocListener<MoviesBloc, MoviesState>(
          listener: (context, state) {
            if (state is NowPlayingMoviesSuccess) {
              nowPlayingMoviesModel.addAll(state.nowPlayingMoviesModel);
              setState(() {});
            }
          },
        ),
        BlocListener<GenresBloc, GenresState>(
          listener: (context, state) {
            if (state is AnimationMoviesSuccess) {
              animationMoviesModel.addAll(state.animationMoviesModel);
              setState(() {});
            }
          },
        ),
        BlocListener<GenresBloc, GenresState>(
          listener: (context, state) {
            if (state is ComedyMoviesSuccess) {
              comedyMoviesModel.addAll(state.comedyMoviesModel);
              setState(() {});
            }
          },
        ),
        BlocListener<GenresBloc, GenresState>(
          listener: (context, state) {
            if (state is RomanticMoviesSuccess) {
              romanticMoviesModel.addAll(state.romanticMoviesModel);
              setState(() {});
            }
          },
        ),
        BlocListener<GenresBloc, GenresState>(
          listener: (context, state) {
            if (state is ThrillerMoviesSuccess) {
              thrillerMoviesModel.addAll(state.thrillerMoviesModel);
              setState(() {});
            }
          },
        ),
        BlocListener<GenresBloc, GenresState>(
          listener: (context, state) {
            if (state is HorrorMoviesSuccess) {
              horrorMoviesModel.addAll(state.horrorMoviesModel);
              setState(() {});
            }
          },
        ),
        BlocListener<GenresBloc, GenresState>(
          listener: (context, state) {
            if (state is TopRatedMoviesSuccess) {
              topRatedMoviesModel.addAll(state.topRatedMoviesModel);
              setState(() {});
            }
          },
        )
      ],
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: h / 20),
              child: Image.asset(
                'assets/images/cinemate_logo.png',
                width: w / 2.5,
                height: h / 12.5,
              ),
            ),
            BlocBuilder<MoviesBloc, MoviesState>(
              builder: (context, state) {
                if (state is NowPlayingMoviesLoading) {
                  return Shimmer.fromColors(
                    baseColor: const Color.fromARGB(31, 220, 217, 217),
                    highlightColor: Colors.white,
                    child: Container(
                      height: 30,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  );
                } else if (state is NowPlayingMoviesSuccess) {
                  return SizedBox(
                    height: h / 4,
                    child: Swiper(
                      itemCount: nowPlayingMoviesModel.length,
                      itemWidth: w / 1.1,
                      layout: SwiperLayout.STACK,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (ctx) => MovieDetailScreen(
                                    id: nowPlayingMoviesModel[index].id!),
                              ),
                            );
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                                'https://image.tmdb.org/t/p/w780${nowPlayingMoviesModel[index].backdropPath}',
                                fit: BoxFit.fill),
                          ),
                        );
                      },
                    ),
                  );
                } else {
                  return Shimmer.fromColors(
                    baseColor: const Color.fromARGB(31, 220, 217, 217),
                    highlightColor: Colors.white,
                    child: Container(
                      height: h / 4,
                      width: w / 1.1,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                    ),
                  );
                }
              },
            ),
            trendingMoviesModel.isNotEmpty
                ? MovieList(
                    text: 'Trending Movies',
                    isSeeAll: true,
                    movieList: trendingMoviesModel,
                    isbox: true)
                : const MOvieListShimmer(),
            topRatedMoviesModel.isNotEmpty
                ? MovieList(
                    text: 'Top Rated Movies',
                    isSeeAll: false,
                    movieList: topRatedMoviesModel,
                    isbox: false)
                : Shimmer.fromColors(
                    baseColor: const Color.fromARGB(31, 220, 217, 217),
                    highlightColor: Colors.white,
                    child: Container(
                        height: h / 7, width: w / 1.2, color: Colors.white),
                  ),
            actionMoviesModel.isNotEmpty
                ? MovieList(
                    text: 'Action Movies',
                    isSeeAll: false,
                    movieList: actionMoviesModel,
                    isbox: true)
                : const MOvieListShimmer(),
            animationMoviesModel.isNotEmpty
                ? MovieList(
                    text: 'Animation Movies',
                    isSeeAll: false,
                    movieList: animationMoviesModel,
                    isbox: true)
                : const MOvieListShimmer(),
            comedyMoviesModel.isNotEmpty
                ? MovieList(
                    text: 'Comedy Movies',
                    isSeeAll: false,
                    movieList: comedyMoviesModel,
                    isbox: true)
                : const MOvieListShimmer(),
            romanticMoviesModel.isNotEmpty
                ? MovieList(
                    text: 'Romantic Movies',
                    isSeeAll: false,
                    movieList: romanticMoviesModel,
                    isbox: true)
                : const MOvieListShimmer(),
            thrillerMoviesModel.isNotEmpty
                ? MovieList(
                    text: 'Thriller Movies',
                    isSeeAll: false,
                    movieList: thrillerMoviesModel,
                    isbox: true)
                : const MOvieListShimmer(),
            horrorMoviesModel.isNotEmpty
                ? MovieList(
                    text: 'Horror Movies',
                    isSeeAll: false,
                    movieList: horrorMoviesModel,
                    isbox: true)
                : const MOvieListShimmer(),
          ],
        ),
      ),
    );
  }
}
