import 'package:flutter/material.dart';
import 'package:movie_app/model/search_movies_model.dart';

// ignore: must_be_immutable
class MovieGrid extends StatefulWidget {
  String text;
  List<MovieSearchModel> movieGrid;
  MovieGrid({super.key, required this.text, required this.movieGrid});

  @override
  State<MovieGrid> createState() => _MovieGridState();
}

class _MovieGridState extends State<MovieGrid> {
  @override
  Widget build(BuildContext context) {
    final double h = MediaQuery.of(context).size.height;
    final double w = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: h / 15, left: w / 25),
            child: Text(
              widget.text,
              style: TextStyle(fontSize: w / 18, fontWeight: FontWeight.w600),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: w / 25, right: w / 25),
            child: SizedBox(
              height: 500,
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: h / 1120),
                itemBuilder: (context, index) {
                  return Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: SizedBox(
                          width: w / 0.1,
                          child: widget.movieGrid[index].posterPath != null
                              ? Image.network(
                                  fit: BoxFit.cover,
                                  'https://image.tmdb.org/t/p/w342${widget.movieGrid[index].posterPath}')
                              : Image.asset('assets/images/cinemate_logo.png'),
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
                  );
                },
                itemCount: widget.movieGrid.length,
              ),
            ),
          )
        ],
      ),
    );
  }
}
