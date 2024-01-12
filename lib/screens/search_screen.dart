import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';
import 'package:movie_app/bloc/movies_bloc.dart';
import 'package:movie_app/model/search_movies_model.dart';
import 'package:movie_app/widgets/movie_grid.dart';
import 'package:shimmer/shimmer.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    Timer? _debounce;
    List<MovieSearchModel> searchMoviesModel = [];
    final double h = MediaQuery.of(context).size.height;
    final double w = MediaQuery.of(context).size.width;
    TextEditingController searchController = TextEditingController();
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
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.orange),
                    borderRadius: BorderRadius.circular(7),
                  ),
                  fillColor: const Color.fromARGB(255, 249, 248, 248),
                  filled: true,
                  prefixIcon: Padding(
                    padding: EdgeInsets.all(h / 45),
                    child: const Icon(
                      Ionicons.search_outline,
                      color: Colors.orange,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                        color: Color.fromARGB(255, 244, 240, 240), width: 1),
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
              if (state is SearchMoviesSuccess) {
                searchMoviesModel.addAll(state.searchMoviesModel);
                return MovieGrid(text: 'Results', movieGrid: searchMoviesModel);
              } else if (state is SearchMoviesLoading) {
                return Shimmer.fromColors(
                  baseColor: const Color.fromARGB(31, 220, 217, 217),
                  highlightColor: Colors.white,
                  child: SizedBox(
                    height: 500,
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2),
                      itemBuilder: (context, index) {
                        return Container(
                          height: 160,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        );
                      },
                      itemCount: 5,
                    ),
                  ),
                );
              } else {
                return const Text("Seach");
              }
            },
          ),
          // Text(searchMoviesModel.isNotEmpty
          //     ? searchMoviesModel[0].posterPath!
          //     : "fsf"),
        ],
      ),
    );
  }
}
