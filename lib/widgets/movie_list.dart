import 'package:flutter/material.dart';

import 'package:movie_app/screens/movie_detail_screen.dart';
import 'package:movie_app/screens/trending_movies_screen.dart';

// ignore: must_be_immutable
class MovieList extends StatefulWidget {
  String text;
  bool isSeeAll;
  List movieList;
  MovieList(
      {super.key,
      required this.text,
      required this.isSeeAll,
      required this.movieList});

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
          padding: EdgeInsets.only(top: h / 50, left: w / 22, right: w / 17),
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
          padding: EdgeInsets.only(top: h / 50, left: w / 20),
          child: SizedBox(
            height: h / 4,
            child: ListView.separated(
              itemCount: 5,
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
                        builder: (ctx) =>
                            MovieDetailScreen(id: widget.movieList[index].id),
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
                          child: Image.network(
                              fit: BoxFit.cover,
                              'https://image.tmdb.org/t/p/w342${widget.movieList[index].posterPath}'),
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
                              widget.movieList[index].voteAverage
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
            ),
          ),
        ),
      ],
    );
  }
}
