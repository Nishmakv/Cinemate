import 'package:flutter/material.dart';

import 'package:movie_app/screens/movie_detail_screen.dart';
import 'package:movie_app/screens/trending_movies_screen.dart';

// ignore: must_be_immutable
class MovieList extends StatefulWidget {
  String text;
  bool isSeeAll;
  List movieList;
  bool isbox;
  MovieList(
      {super.key,
      required this.text,
      required this.isSeeAll,
      required this.movieList,
      required this.isbox});

  @override
  State<MovieList> createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {
  @override
  Widget build(BuildContext context) {
    final double w = MediaQuery.of(context).size.width;
    final double h = MediaQuery.of(context).size.height;
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(top: h / 60, left: w / 22, right: w / 17),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.text,
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: w / 22),
              ),
              widget.isSeeAll
                  ? GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (ctx) => const TrendingMoviesScreen(),
                          ),
                        );
                      },
                      child: Text(
                        'See all',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.orange,
                            fontSize: w / 25),
                      ),
                    )
                  : const SizedBox(),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: h / 70, left: w / 20),
          child: widget.isbox
              ? SizedBox(
                  height: h / 4,
                  child: ListView.separated(
                    itemCount: widget.movieList.length,
                    scrollDirection: Axis.horizontal,
                    separatorBuilder: (context, index) {
                      return SizedBox(width: w / 40);
                    },
                    itemBuilder: (context, index) {
                      return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (ctx) => MovieDetailScreen(
                                    id: widget.movieList[index].id),
                              ),
                            );
                          },
                          child: Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: SizedBox(
                                  height: h / 3.8,
                                  width: w / 3,
                                  child: widget.movieList[index].posterPath !=
                                          null
                                      ? Image.network(
                                          fit: BoxFit.cover,
                                          'https://image.tmdb.org/t/p/w342${widget.movieList[index].posterPath}')
                                      : Image.asset(
                                          'assets/images/cinemate_logo.png',
                                          fit: BoxFit.cover),
                                ),
                              ),
                              Positioned(
                                top: h / 75,
                                left: w / 40,
                                child: widget.movieList[index].voteAverage !=
                                        0.0
                                    ? Container(
                                        height: h / 35,
                                        width: w / 13,
                                        decoration: BoxDecoration(
                                          color: Colors.orange,
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        child: Center(
                                          child: Text(
                                            widget.movieList[index].voteAverage
                                                .toStringAsFixed(1),
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: w / 35),
                                          ),
                                        ),
                                      )
                                    : const SizedBox(),

                              ),
                            ],
                          ),
                          );
                    },
                  ),
                )
              : SizedBox(
                  height: h / 7,
                  child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (ctx) => MovieDetailScreen(
                                    id: widget.movieList[index].id),
                              ),
                            );
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: SizedBox(
                              width: w / 1.7,
                              child: Image.network(
                                  'https://image.tmdb.org/t/p/w342${widget.movieList[index].backdropPath}',
                                  fit: BoxFit.cover),
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return SizedBox(width: w / 60);
                      },
                      itemCount: widget.movieList.length),
                ),
        ),
      ],
    );
  }
}
