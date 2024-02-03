import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:ionicons/ionicons.dart';
import 'package:movie_app/bloc/navigation_bloc.dart';

import 'package:movie_app/screens/movie_detail_screen.dart';

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
          padding: EdgeInsets.only(top: h / 300, left: w / 22, right: w / 17),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.text,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: w / 22,
                  color: Theme.of(context).brightness == Brightness.light
                      ? Colors.black
                      : Colors.white,
                ),
              ),
              widget.isSeeAll
                  ? GestureDetector(
                      onTap: () {
                        context.read<NavigationBloc>().add(
                              const NavigationProcess(index: 1),
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
                  child: AnimationLimiter(
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
                          child: AnimationConfiguration.staggeredList(
                            position: index,
                            duration: const Duration(milliseconds: 500),
                            child: FadeInAnimation(
                              child: Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: SizedBox(
                                      height: h / 3.8,
                                      width: w / 3,
                                      child: widget.movieList[index]
                                                  .posterPath !=
                                              null
                                          ? CachedNetworkImage(
                                              imageUrl:
                                                  'https://image.tmdb.org/t/p/w780${widget.movieList[index].posterPath}',
                                              fit: BoxFit.cover,
                                              progressIndicatorBuilder:
                                                  (context, url,
                                                          downloadProgress) =>
                                                      Center(
                                                child:
                                                    CircularProgressIndicator(
                                                        color: Colors.orange,
                                                        value: downloadProgress
                                                            .progress),
                                              ),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      const Icon(
                                                          Ionicons.bug_outline),
                                            )
                                          : Image.asset(
                                              'assets/images/cinemate_logo.png',
                                              fit: BoxFit.cover),
                                    ),
                                  ),
                                  Positioned(
                                    top: h / 75,
                                    left: w / 40,
                                    child: widget
                                                .movieList[index].voteAverage !=
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
                                                widget.movieList[index]
                                                    .voteAverage
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
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                )
              : SizedBox(
                  height: h / 5.5,
                  child: AnimationLimiter(
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
                            child: AnimationConfiguration.staggeredList(
                              position: index,
                              duration: const Duration(milliseconds: 500),
                              child: FadeInAnimation(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: SizedBox(
                                    width: w / 1.7,
                                    child: widget.movieList[index]
                                                .backdropPath !=
                                            null
                                        ? CachedNetworkImage(
                                            imageUrl:
                                                'https://image.tmdb.org/t/p/w780${widget.movieList[index].backdropPath}',
                                            fit: BoxFit.cover,
                                            progressIndicatorBuilder: (context,
                                                    url, downloadProgress) =>
                                                Center(
                                              child: CircularProgressIndicator(
                                                  value:
                                                      downloadProgress.progress,
                                                  color: Colors.orange),
                                            ),
                                            errorWidget:
                                                (context, url, error) =>
                                                    const Icon(
                                                        Ionicons.bug_outline),
                                          )
                                        : Image.asset(
                                            'assets/images/cinemate_logo.png',
                                            fit: BoxFit.contain),
                                  ),
                                ),
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
        ),
      ],
    );
  }
}
