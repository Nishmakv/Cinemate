import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';
import 'package:movie_app/bloc/movies_bloc.dart';
import 'package:movie_app/model/search_movies_model.dart';
import 'package:movie_app/widgets/movie_grid.dart';
import 'package:movie_app/widgets/trend_search_shimmer.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Timer? _debounce;
    List<MovieSearchModel> searchMoviesModel = [];
    final double h = MediaQuery.of(context).size.height;
    final double w = MediaQuery.of(context).size.width;

    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: h / 15, left: w / 30, right: w / 30),
            child: SizedBox(
              height: h / 13.5,
              child: TextFormField(
                controller: searchController,
                onChanged: (value) {
                  if (_debounce?.isActive ?? false) {
                    _debounce?.cancel();
                  }
                  _debounce = Timer(const Duration(milliseconds: 500), () {
                    context.read<MoviesBloc>().add(
                          SearchMovieProcess(name: value),
                        );
                  });
                },
                onFieldSubmitted: (value) {
                  context.read<MoviesBloc>().add(
                        SearchMovieProcess(name: value),
                      );
                },
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.orange),
                    borderRadius: BorderRadius.circular(7),
                  ),
                  fillColor: Theme.of(context).brightness == Brightness.light
                      ? const Color.fromARGB(255, 249, 248, 248)
                      : const Color.fromARGB(21, 224, 224, 224),
                  filled: true,
                  prefixIcon: Padding(
                    padding: EdgeInsets.all(h / 45),
                    child: const Icon(
                      Ionicons.search_outline,
                      color: Colors.orange,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide:  BorderSide(
                        color: Theme.of(context).brightness == Brightness.light
                            ? const Color.fromARGB(255, 244, 240, 240)
                            : Colors.black),
                    borderRadius: BorderRadius.circular(7),
                  ),
                  hintText: 'Search Movies',
                  contentPadding: EdgeInsets.all(h / 45),
                  hintStyle: const TextStyle(
                    color: Color(0xFF7C7C7C),
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
          ),
          BlocBuilder<MoviesBloc, MoviesState>(
            builder: (context, state) {
              if (state is SearchMoviesLoading) {
                return const TrendingShimmer();
              } else if (state is SearchMoviesSuccess) {
                searchMoviesModel.addAll(state.searchMoviesModel);
                return MovieGrid(movieGrid: searchMoviesModel);
              } else {
                return Padding(
                  padding: EdgeInsets.only(top: h / 3),
                  child: Text(
                    'Search Here',
                    style: TextStyle(
                        fontSize: w / 20,
                        color: Theme.of(context).brightness == Brightness.light
                            ? Colors.black
                            : Colors.white),
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
