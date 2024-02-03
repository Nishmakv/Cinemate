import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/bloc/movies_bloc.dart';
import 'package:movie_app/model/trending_movies_model.dart';
import 'package:movie_app/widgets/movie_grid.dart';
import 'package:movie_app/widgets/trend_search_shimmer.dart';

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
          final double h = MediaQuery.of(context).size.height;

          if (state is MoviesLoading) {
            return const TrendingShimmer();
          } else {
            return Padding(
              padding: EdgeInsets.only(top: h / 40),
              child: SingleChildScrollView(
                child: MovieGrid(movieGrid: trendingMoviesModel),
              ),
            );
          }
        },
      ),
    );
  }
}
