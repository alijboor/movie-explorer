import 'package:flutter/material.dart';
import 'package:movie_explorer/core/constants/api_routes.dart';
import 'package:movie_explorer/core/constants/lang_keys.dart';
import 'package:movie_explorer/domain/entities/movie_entity.dart';
import 'package:movie_explorer/features/home/providers/home_provider.dart';
import 'package:movie_explorer/features/home/widgets/rating_favorite_action_row.dart';
import 'package:provider/provider.dart';

class MovieDetailsScreen extends StatelessWidget {
  final MovieEntity movie;

  const MovieDetailsScreen({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(builder: (context, homeProvider, child) {
      return Scaffold(
        appBar: AppBar(title: Text(movie.title), leading: const BackButton()),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network('${ApiRoutes.imageRoute}${movie.posterPath}'),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      movie.title,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    RatingFavoriteActionRow(
                      movie: movie,
                      isFav: homeProvider.favManager.isFavorite,
                      toggleFav: homeProvider.toggleFavState,
                    ),
                    _space,
                    Text('${LangKeys.releaseDate}: ${movie.releaseDate}'),
                    _space,
                    Text(movie.overview),
                    _space
                  ],
                ),
              )
            ],
          ),
        ),
      );
    });
  }

  Widget get _space => const SizedBox(height: 15.0);
}
