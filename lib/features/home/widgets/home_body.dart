import 'package:flutter/material.dart';
import 'package:movie_explorer/core/constants/lang_keys.dart';
import 'package:movie_explorer/features/home/providers/home_provider.dart';
import 'package:movie_explorer/features/home/widgets/movies_grid_builder.dart';
import 'package:provider/provider.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(builder: (context, homeProvider, child) {
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: homeProvider.searchController,
              decoration: InputDecoration(
                hintText: LangKeys.searchHint,
                border: const OutlineInputBorder(),
                suffixIcon: homeProvider.searchController.text.isEmpty
                    ? const SizedBox()
                    : IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: homeProvider.clearSearch),
              ),
              onChanged: homeProvider.searchMoviesByQuery,
            ),
          ),
          Expanded(
            child: homeProvider.isLoading
                ? const Center(child: CircularProgressIndicator())
                : homeProvider.movies.isEmpty
                    ? Center(child: Text(LangKeys.emptyMovies))
                    : MoviesGridBuilder(movies: homeProvider.movies),
          ),
        ],
      );
    });
  }
}
