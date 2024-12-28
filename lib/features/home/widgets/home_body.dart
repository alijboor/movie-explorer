import 'package:flutter/material.dart';
import 'package:movie_explorer/features/home/providers/home_provider.dart';
import 'package:movie_explorer/features/home/widgets/movies_grid_builder.dart';
import 'package:provider/provider.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(builder: (context, homeProvider, child) {
      return homeProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : MoviesGridBuilder(movies: homeProvider.movies);
    });
  }
}
