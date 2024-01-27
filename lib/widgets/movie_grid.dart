import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:movie_app/model/search_movies_model.dart';
import 'package:movie_app/model/trending_movies_model.dart';
import 'package:movie_app/screens/movie_detail_screen.dart';

// ignore: must_be_immutable
class MovieGrid extends StatefulWidget {
  List movieGrid;
  MovieGrid({super.key, required this.movieGrid});

  @override
  State<MovieGrid> createState() => _MovieGridState();
}

class _MovieGridState extends State<MovieGrid> {
  List<TrendingMovies> trendingMoviesModel = [];

  @override
  Widget build(BuildContext context) {
    final double h = MediaQuery.of(context).size.height;
    final double w = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: h / 1,
            child: Padding(
              padding: EdgeInsets.only(left: w / 25, right: w / 25),
              child: AnimationLimiter(
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
                      child: AnimationConfiguration.staggeredGrid(
                        position: index,
                        columnCount: 2,
                        child: FadeInAnimation(
                          child: Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: SizedBox(
                                  width: w / 0.1,
                                  child: widget.movieGrid[index].posterPath != null
                                      ? CachedNetworkImage(
                                          imageUrl:
                                              'https://image.tmdb.org/t/p/w342${widget.movieGrid[index].posterPath}',
                                          fit: BoxFit.cover,
                                          progressIndicatorBuilder:
                                              (context, url, downloadProgress) =>
                                                  Center(
                                            child: CircularProgressIndicator(
                                              value: downloadProgress.progress,
                                              color: Colors.orange,
                                            ),
                                          ),
                                        )
                                      : Image.asset(
                                          'assets/images/cinemate_logo.png'),
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
                                      widget.movieGrid[0].voteAverage
                                              ?.toStringAsFixed(1) ??
                                          "0",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: w / 30),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  itemCount: widget.movieGrid.length,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
