import 'package:flutter/material.dart';
import 'package:movie_explorer/core/constants/lang_keys.dart';
import 'package:movie_explorer/domain/entities/movie_entity.dart';
import 'package:movie_explorer/features/home/widgets/movies_grid_builder.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({required this.favoriteMovies, super.key});
  final List<MovieEntity> favoriteMovies;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            leading: const BackButton(), title: Text(LangKeys.favScreen)),
        body: favoriteMovies.isEmpty
            ? Center(child: Text(LangKeys.emptyFavScreen))
            : MoviesGridBuilder.withoutLoadMore(movies: favoriteMovies));
  }
}
