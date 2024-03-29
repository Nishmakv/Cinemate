import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';
import 'package:movie_app/bloc/navigation_bloc.dart';
import 'package:movie_app/screens/home_tab.dart';
import 'package:movie_app/screens/search_screen.dart';
import 'package:movie_app/screens/trending_movies_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;
  List screens = [
    const HomeTab(),
    const TrendingMoviesScreen(),
    const SearchScreen()
  ];
  @override
  Widget build(BuildContext context) {
    final double w = MediaQuery.of(context).size.width;
    final double h = MediaQuery.of(context).size.height;
    return BlocListener<NavigationBloc, int>(
      listener: (context, state) {
        setState(() {
          selectedIndex = state;
        });
      },
      child: Scaffold(
        extendBodyBehindAppBar: true,
        extendBody: true,
        backgroundColor: Theme.of(context).colorScheme.background,
        body: screens[selectedIndex],
        bottomNavigationBar: Padding(
          padding: EdgeInsets.all(h / 38),
          child: DotNavigationBar(
            itemPadding: const EdgeInsets.all(14),
            boxShadow: const [
              BoxShadow(
                blurRadius: 12,
                color: Color.fromRGBO(0, 0, 0, 0.038),
              ),
            ],
            currentIndex: context.watch<NavigationBloc>().state,
            dotIndicatorColor: const Color.fromARGB(0, 0, 0, 0),
            marginR: EdgeInsets.symmetric(horizontal: w / 15, vertical: 0),
            paddingR: EdgeInsets.symmetric(horizontal: w / 30, vertical: 0),
            enableFloatingNavBar: true,
            enablePaddingAnimation: true,
            selectedItemColor: Colors.black,
            unselectedItemColor: Colors.grey,
            onTap: (index) {
              context
                  .read<NavigationBloc>()
                  .add(NavigationProcess(index: index));
            },
            items: [
              DotNavigationBarItem(
                icon: const Icon(Ionicons.home),
              ),
              DotNavigationBarItem(
                icon: const Icon(Ionicons.flame),
              ),
              DotNavigationBarItem(
                icon: const Icon(Ionicons.search),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
