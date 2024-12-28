import 'package:flutter/material.dart';
import 'package:movie_explorer/domain/entities/movie_entity.dart';
import 'package:movie_explorer/features/home/providers/home_provider.dart';
import 'package:movie_explorer/features/home/widgets/poster_image.dart';
import 'package:movie_explorer/features/home/widgets/rating_icon.dart';
import 'package:provider/provider.dart';

class MoviesGridBuilder extends StatelessWidget {
  const MoviesGridBuilder({required this.movies, super.key})
      : _withLoadMore = true;

  const MoviesGridBuilder.withoutLoadMore({required this.movies, super.key})
      : _withLoadMore = false;

  final List<MovieEntity> movies;
  final bool _withLoadMore;

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(builder: (context, homeProvider, child) {
      return GridView.builder(
          controller: _withLoadMore ? homeProvider.scrollController : null,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 8.0,
              childAspectRatio: 0.54),
          itemCount: movies.length +
              ((_withLoadMore && homeProvider.isFetchingMore) ? 1 : 0),
          itemBuilder: (context, index) {
            if (_withLoadMore && index == movies.length) {
              return const Center(child: CircularProgressIndicator());
            }
            final movie = movies[index];
            return Container(
              margin: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(15)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  PosterImage(posterImagePath: movie.posterPath),
                  const SizedBox(height: 5.0),
                  Text(movie.title,
                      maxLines: 1, overflow: TextOverflow.ellipsis),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          RatingIcon(
                              iconColor: Colors.yellowAccent,
                              rating: movie.rating),
                          Text(movie.rating.toStringAsFixed(1))
                        ],
                      ),
                      IconButton(
                        icon: Icon(homeProvider.favManager.isFavorite(movie)
                            ? Icons.favorite
                            : Icons.favorite_border),
                        color: Colors.red,
                        onPressed: () =>
                            homeProvider.toggleFavState(movie),
                      ),
                    ],
                  ),
                ],
              ),
            );
          });
    });
  }
}
