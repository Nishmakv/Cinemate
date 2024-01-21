import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';
import 'package:movie_app/bloc/movies_bloc.dart';
import 'package:movie_app/model/movie_details_by_id_model.dart';
import 'package:intl/intl.dart';
import 'package:movie_app/model/search_movies_model.dart';
import 'package:movie_app/widgets/movie_list.dart';
import 'package:movie_app/widgets/movie_list_shimmer.dart';
import 'package:movie_app/widgets/text_shimmer.dart';
import 'package:readmore/readmore.dart';
import 'package:shimmer/shimmer.dart';

// ignore: must_be_immutable
class MovieDetailScreen extends StatefulWidget {
  int id;
  MovieDetailScreen({super.key, required this.id});

  @override
  State<MovieDetailScreen> createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  MovieDetailsById? movieDetailsByIdModel;
  List<MovieSearchModel> movieRecommendations = [];
  List<MovieSearchModel> similarMoviesModel = [];
  @override
  void initState() {
    super.initState();
    context.read<MoviesBloc>().add(
          MovieDetailsByIdProcess(id: widget.id),
        );
    context.read<MoviesBloc>().add(
          MovieRecommendationsProcess(id: widget.id),
        );
    context.read<MoviesBloc>().add(
          SimilarMoviesProcess(id: widget.id),
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
            if (state is MovieDetialsByIdSuccess) {
              movieDetailsByIdModel = state.movieDetailsByIdModel;
              setState(() {});
            }
          },
        ),
        BlocListener<MoviesBloc, MoviesState>(
          listener: (context, state) {
            if (state is MovieRecommendationsSuccess) {
              movieRecommendations.addAll(state.movieRecommendations);
              setState(() {});
            }
          },
        ),
        BlocListener<MoviesBloc, MoviesState>(
          listener: (context, state) {
            if (state is SimilarMoviesSuccess) {
              similarMoviesModel.addAll(state.similarMoviesModel);
              setState(() {});
            }
          },
        )
      ],
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    BlocBuilder<MoviesBloc, MoviesState>(
                      builder: (context, state) {
                        if (state is MovieDetailsByIdLoading) {
                          return Shimmer.fromColors(
                            baseColor: const Color.fromARGB(31, 220, 217, 217),
                            highlightColor: Colors.white,
                            child: Container(
                              height: h / 3,
                              width: w / 1,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          );
                        }

                        return SizedBox(
                            height: h / 3,
                            width: w / 1,
                            child: Image.network(
                                'https://image.tmdb.org/t/p/w780/${movieDetailsByIdModel?.backdropPath ?? ''}',
                                fit: BoxFit.cover));
                      },
                    ),
                    Positioned(
                      top: h / 25,
                      left: w / 20,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const CircleAvatar(
                          radius: 20,
                          backgroundColor: Color.fromARGB(57, 255, 255, 255),
                          child: Icon(Ionicons.chevron_back_outline),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.all(h / 50),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BlocBuilder<MoviesBloc, MoviesState>(
                        builder: (context, state) {
                          if (state is MovieDetailsByIdLoading) {
                            return const TextShimmer();
                          } else {
                            return Text(
                              movieDetailsByIdModel?.originalTitle ?? '',
                              style: TextStyle(
                                  fontSize: h / 32,
                                  fontWeight: FontWeight.w600),
                            );
                          }
                        },
                      ),
                      SizedBox(height: h / 55),
                      BlocBuilder<MoviesBloc, MoviesState>(
                        builder: (context, state) {
                          if (state is MovieDetailsByIdLoading) {
                            return const TextShimmer();
                          } else {
                            return Row(
                              children: [
                                const Icon(Ionicons.time_outline, size: 15),
                                SizedBox(width: w / 80),
                                Text(
                                  movieDetailsByIdModel?.runtime.toString() ??
                                      '',
                                  style: TextStyle(fontSize: w / 30),
                                ),
                                SizedBox(width: w / 100),
                                Text(
                                  'minutes',
                                  style: TextStyle(fontSize: w / 32),
                                ),
                                SizedBox(width: w / 20),
                                const Icon(Ionicons.star,
                                    color: Color.fromARGB(255, 255, 230, 0),
                                    size: 17),
                                SizedBox(width: w / 55),
                                Text(
                                  movieDetailsByIdModel?.voteAverage
                                          ?.toStringAsFixed(1) ??
                                      '',
                                  style: TextStyle(fontSize: w / 30),
                                ),
                                SizedBox(width: w / 100),
                                Text(
                                  '(IMDb)',
                                  style: TextStyle(fontSize: w / 30),
                                )
                              ],
                            );
                          }
                        },
                      ),
                      const Divider(color: Color.fromARGB(26, 0, 0, 0)),
                      BlocBuilder<MoviesBloc, MoviesState>(
                        builder: (context, state) {
                          if (state is MovieDetailsByIdLoading) {
                            return const TextShimmer();
                          } else {
                            return Row(
                              children: [
                                Expanded(
                                  flex: 4,
                                  child: Text(
                                    'Release Date',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: w / 25,
                                    ),
                                  ),
                                ),
                                const Expanded(
                                  flex: 6,
                                  child: Text(
                                    'Genre',
                                    style:
                                        TextStyle(fontWeight: FontWeight.w600),
                                  ),
                                )
                              ],
                            );
                          }
                        },
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      BlocBuilder<MoviesBloc, MoviesState>(
                        builder: (context, state) {
                          if (state is MovieDetailsByIdLoading) {
                            return const TextShimmer();
                          } else {
                            return Row(
                              children: [
                                Expanded(
                                  flex: 4,
                                  child: Text(
                                    DateFormat('MMMM d,yyy').format(
                                      movieDetailsByIdModel?.releaseDate ??
                                          DateTime.now(),
                                    ),
                                    style: TextStyle(fontSize: w / 28),
                                  ),
                                ),
                                Expanded(
                                  flex: 6,
                                  child: SizedBox(
                                    height: h / 30,
                                    child: ListView.separated(
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, index) {
                                          return Container(
                                            padding: EdgeInsets.only(
                                                top: h / 800,
                                                left: w / 50,
                                                right: w / 50),
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color: const Color.fromARGB(
                                                    47, 0, 0, 0),
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            child: Center(
                                              child: Text(
                                                movieDetailsByIdModel
                                                        ?.genres[index].name ??
                                                    '',
                                                style: TextStyle(
                                                    fontSize: w / 33,
                                                    height: 1),
                                              ),
                                            ),
                                          );
                                        },
                                        separatorBuilder: (context, index) {
                                          return const SizedBox(width: 8);
                                        },
                                        itemCount: movieDetailsByIdModel
                                                ?.genres.length ??
                                            0),
                                  ),
                                ),
                              ],
                            );
                          }
                        },
                      ),
                      const Divider(color: Color.fromARGB(26, 0, 0, 0)),
                      BlocBuilder<MoviesBloc, MoviesState>(
                        builder: (context, state) {
                          if (state is MovieDetailsByIdLoading) {
                            return const TextShimmer();
                          } else {
                            return Text(
                              'Synposis',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: w / 22),
                            );
                          }
                        },
                      ),
                      SizedBox(height: h / 55),
                      BlocBuilder<MoviesBloc, MoviesState>(
                        builder: (context, state) {
                          if (state is MovieDetailsByIdLoading) {
                            return const TextShimmer();
                          } else {
                            return ReadMoreText(
                              movieDetailsByIdModel?.overview ?? '',
                              trimCollapsedText: 'read more',
                              trimExpandedText: 'read less',
                              trimMode: TrimMode.Length,
                              colorClickableText: Colors.black,
                              moreStyle:
                                  const TextStyle(fontWeight: FontWeight.w600),
                              style: TextStyle(fontSize: w / 28),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
                movieRecommendations.isNotEmpty
                    ? MovieList(
                        text: 'Recommended Movies',
                        isSeeAll: false,
                        movieList: movieRecommendations,
                        isbox: true,
                      )
                    : const SizedBox(),
                similarMoviesModel.isNotEmpty
                    ? MovieList(
                        text: 'Related Movies',
                        isSeeAll: false,
                        movieList: similarMoviesModel,
                        isbox: true,
                      )
                    : const MOvieListShimmer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
