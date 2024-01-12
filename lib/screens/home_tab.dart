import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/bloc/movies_bloc.dart';
import 'package:movie_app/model/search_movies_model.dart';
import 'package:movie_app/model/trending_movies_model.dart';
import 'package:movie_app/screens/movie_detail_screen.dart';
import 'package:movie_app/widgets/movie_list.dart';
import 'package:shimmer/shimmer.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  List<TrendingMovies> trendingMoviesModel = [];
  List<MovieSearchModel> actionMoviesModel = [];
  List<MovieSearchModel> nowPlayingMoviesModel = [];
  @override
  void initState() {
    super.initState();
    context.read<MoviesBloc>().add(
          const MovieProcess(),
        );
    context.read<MoviesBloc>().add(
          const ActionMoviesProcess(),
        );
    context.read<MoviesBloc>().add(
          const NowPlayingMoviesProcess(),
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
        BlocListener<MoviesBloc, MoviesState>(
          listener: (context, state) {
            if (state is ActionMoviesSuccess) {
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
                      height: h / 4,
                      width: w / 1.1,
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
                                'https://image.tmdb.org/t/p/w342${nowPlayingMoviesModel[index].backdropPath}',
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
                      ),
                    ),
                  );
                }
              },
            ),
            MovieList(
              text: 'Trending Movies',
              isSeeAll: true,
              movieList: trendingMoviesModel,
            ),
          ],

          // BlocBuilder<MoviesBloc, MoviesState>(
          //   builder: (context, state) {
          //     if (state is ActionMoviesLoading) {
          //       return MOvieListShimmer();
          //     } else if (state is ActionMoviesSuccess) {
          //       return MovieList(
          //           text: 'Action Movies',
          //           isSeeAll: false,
          //           movieList: actionMoviesModel);
          //     } else {
          //       return MOvieListShimmer();
          //     }
          //   },
          // ),
        ),
      ),
    );
  }
}
