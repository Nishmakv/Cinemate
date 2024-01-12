import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';
import 'package:movie_app/bloc/movies_bloc.dart';
import 'package:movie_app/model/movie_details_by_id_model.dart';
import 'package:intl/intl.dart';
import 'package:movie_app/model/search_movies_model.dart';
import 'package:movie_app/widgets/movie_list.dart';
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
              movieRecommendations.addAll(state.searchMoviesModel);
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
                            child: Container(height: h / 3, width: w / 1),
                          );
                        }
                        return SizedBox(
                          height: h / 3,
                          width: w / 1,
                          child: Image.network(
                              'https://image.tmdb.org/t/p/w342/${movieDetailsByIdModel?.backdropPath ?? ''}',
                              fit: BoxFit.cover),
                        );
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
                      Text(
                        movieDetailsByIdModel?.originalTitle ?? '',
                        style: TextStyle(
                            fontSize: h / 40, fontWeight: FontWeight.w600),
                      ),
                      Row(
                        children: [
                          const Icon(Ionicons.time_outline, size: 15),
                          SizedBox(width: w / 80),
                          Text(
                            movieDetailsByIdModel?.runtime.toString() ?? '',
                            style: TextStyle(fontSize: w / 25),
                          ),
                          SizedBox(width: w / 50),
                          Text(
                            'minutes',
                            style: TextStyle(fontSize: w / 30),
                          ),
                          SizedBox(width: w / 20),
                          const Icon(Ionicons.star,
                              color: Color.fromARGB(255, 255, 230, 0),
                              size: 15),
                          SizedBox(width: w / 55),
                          Text(movieDetailsByIdModel?.voteAverage
                                  ?.toStringAsFixed(1) ??
                              ''),
                          SizedBox(width: w / 100),
                          const Text('(IMDb)')
                        ],
                      ),
                      const Divider(color: Color.fromARGB(26, 0, 0, 0)),
                      Row(
                        children: [
                          Text(
                            'Release Date',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: w / 25,
                            ),
                          ),
                          SizedBox(width: w / 10),
                          Padding(
                            padding: EdgeInsets.only(left: w / 13),
                            child: const Text(
                              'Genre',
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            DateFormat('MMMM d,yyy').format(
                              movieDetailsByIdModel?.releaseDate ??
                                  DateTime.now(),
                            ),
                            style: TextStyle(fontSize: w / 28),
                          ),
                          SizedBox(width: w / 10),
                          Expanded(
                            child: SizedBox(
                              height: h / 23,
                              child: ListView.separated(
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      padding: EdgeInsets.all(h / 100),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: const Color.fromARGB(
                                                47, 0, 0, 0)),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Center(
                                        child: Text(
                                          movieDetailsByIdModel
                                                  ?.genres[index].name ??
                                              '',
                                          style: TextStyle(
                                            fontSize: w / 30,
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                  separatorBuilder: (context, index) {
                                    return const SizedBox(width: 20);
                                  },
                                  itemCount:
                                      movieDetailsByIdModel?.genres.length ??
                                          0),
                            ),
                          ),
                        ],
                      ),
                      const Divider(color: Color.fromARGB(26, 0, 0, 0)),
                      Text(
                        'Synposis',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: w / 22),
                      ),
                      Text(
                        movieDetailsByIdModel?.overview ?? '',
                        style: TextStyle(fontSize: w / 28),
                      ),
                      movieRecommendations.isNotEmpty
                          ? MovieList(
                              text: 'Related Movies',
                              isSeeAll: false,
                              movieList: movieRecommendations)
                          : const SizedBox(),
                    ],
                  ),
                ),
                MovieList(
                    text: 'Related Movies',
                    isSeeAll: false,
                    movieList: similarMoviesModel),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
