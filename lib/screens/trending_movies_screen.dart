import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/bloc/movies_bloc.dart';
import 'package:movie_app/model/trending_movies_model.dart';
import 'package:movie_app/screens/movie_detail_screen.dart';
import 'package:shimmer/shimmer.dart';

class TrendingMoviesScreen extends StatefulWidget {
  const TrendingMoviesScreen({super.key});

  @override
  State<TrendingMoviesScreen> createState() => _TrendingMoviesScreenState();
}

class _TrendingMoviesScreenState extends State<TrendingMoviesScreen> {
  List<TrendingMovies> trendingMoviesModel = [];
  @override
  void initState() {
    super.initState();
    context.read<MoviesBloc>().add(
          const MovieProcess(),
        );
  }

  @override
  Widget build(BuildContext context) {
    final double h = MediaQuery.of(context).size.height;
    final double w = MediaQuery.of(context).size.width;
    return BlocListener<MoviesBloc, MoviesState>(
      listener: (context, state) {
        if (state is MoviesSuccess) {
          trendingMoviesModel.addAll(state.trendingMoviesModel);
          setState(() {});
        }
      },
      child: BlocBuilder<MoviesBloc, MoviesState>(
        builder: (context, state) {
          if (state is MoviesLoading) {
            return Shimmer.fromColors(
              baseColor: const Color.fromARGB(31, 220, 217, 217),
              highlightColor: Colors.white,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 160,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    )
                  ],
                ),
              ),
            );
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: h / 15, left: w / 25),
                child: Text(
                  'Trending Movies',
                  style:
                      TextStyle(fontSize: w / 18, fontWeight: FontWeight.w600),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: w / 25, right: w / 25),
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        childAspectRatio: h / 1120),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (ctx) => MovieDetailScreen(
                                  id: trendingMoviesModel[index].id),
                            ),
                          );
                        },
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: SizedBox(
                                width: w / 0.1,
                                child: Image.network(
                                    fit: BoxFit.cover,
                                    'https://image.tmdb.org/t/p/w342${trendingMoviesModel[index].posterPath}'),
                              ),
                            ),
                            Positioned(
                              top: h / 75,
                              left: w / 40,
                              child: Container(
                                height: h / 22,
                                width: w / 10,
                                decoration: BoxDecoration(
                                  color: Colors.orange,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Center(
                                  child: Text(
                                    trendingMoviesModel[index]
                                        .voteAverage
                                        .toStringAsFixed(1),
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: w / 30),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    itemCount: trendingMoviesModel.length,
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
