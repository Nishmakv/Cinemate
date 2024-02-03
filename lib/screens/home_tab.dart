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
    final ThemeData theme=Theme.of(context);
    final Color baseColor = theme.brightness == Brightness.light
        ? const Color.fromARGB(31, 220, 217, 217)
        : const Color.fromARGB(31, 220, 217, 217);
    final Color highlightColor =
        theme.brightness == Brightness.light ? Colors.white : const Color.fromARGB(31, 220, 217, 217);
         final Color containerColor= theme.brightness == Brightness.light ? Colors.white : const Color.fromARGB(154, 220, 217, 217);
   
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
            nowPlayingMoviesModel.isNotEmpty
                ? SizedBox(
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
                  )
                : Shimmer.fromColors(
                    baseColor: baseColor,
                    highlightColor: highlightColor,
                    child: Container(
                      height: h / 4,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: containerColor,
                      ),
                    ),
                  ),
            SizedBox(height: h / 60),
            trendingMoviesModel.isNotEmpty
                ? MovieList(
                    text: 'Trending Movies',
                    isSeeAll: true,
                    movieList: trendingMoviesModel,
                    isbox: true)
                : MOvieListShimmer(
                    theme: Theme.of(context),
                  ),
            SizedBox(height: h / 60),
            topRatedMoviesModel.isNotEmpty
                ? MovieList(
                    text: 'Top Rated Movies',
                    isSeeAll: false,
                    movieList: topRatedMoviesModel,
                    isbox: false)
                : Padding(
                    padding: EdgeInsets.only(left: w / 20),
                    child: Shimmer.fromColors(
                      baseColor: baseColor,
                      highlightColor: highlightColor,
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: h / 7,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: containerColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          SizedBox(width: w/40),
                          Expanded(
                        child: Container(
                          height: h / 7,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: containerColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                        ],
                      ),
                      
                    ),
                  ),
            SizedBox(height: h / 60),
            actionMoviesModel.isNotEmpty
                ? MovieList(
                    text: 'Action Movies',
                    isSeeAll: false,
                    movieList: actionMoviesModel,
                    isbox: true)
                : MOvieListShimmer(theme: Theme.of(context)),
            SizedBox(height: h / 60),
            animationMoviesModel.isNotEmpty
                ? MovieList(
                    text: 'Animation Movies',
                    isSeeAll: false,
                    movieList: animationMoviesModel,
                    isbox: true)
                : MOvieListShimmer(theme: Theme.of(context)),
            SizedBox(height: h / 60),
            comedyMoviesModel.isNotEmpty
                ? MovieList(
                    text: 'Comedy Movies',
                    isSeeAll: false,
                    movieList: comedyMoviesModel,
                    isbox: true)
                : MOvieListShimmer(theme: Theme.of(context)),
            SizedBox(height: h / 60),
            romanticMoviesModel.isNotEmpty
                ? MovieList(
                    text: 'Romantic Movies',
                    isSeeAll: false,
                    movieList: romanticMoviesModel,
                    isbox: true)
                : MOvieListShimmer(theme: Theme.of(context)),
            SizedBox(height: h / 60),
            thrillerMoviesModel.isNotEmpty
                ? MovieList(
                    text: 'Thriller Movies',
                    isSeeAll: false,
                    movieList: thrillerMoviesModel,
                    isbox: true)
                : MOvieListShimmer(theme: Theme.of(context)),
            SizedBox(height: h / 60),
            horrorMoviesModel.isNotEmpty
                ? MovieList(
                    text: 'Horror Movies',
                    isSeeAll: false,
                    movieList: horrorMoviesModel,
                    isbox: true)
                : MOvieListShimmer(theme: Theme.of(context)),
          ],
        ),
      ),
    );
  }
}
