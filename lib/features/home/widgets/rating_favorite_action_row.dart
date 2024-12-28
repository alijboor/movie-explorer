import 'package:flutter/material.dart';
import 'package:movie_explorer/domain/entities/movie_entity.dart';
import 'package:movie_explorer/features/home/widgets/rating_icon.dart';

class RatingFavoriteActionRow extends StatelessWidget {
  const RatingFavoriteActionRow(
      {required this.movie,
      required this.isFav,
      required this.toggleFav,
      super.key});
  final MovieEntity movie;
  final bool Function(MovieEntity) isFav;
  final ValueChanged<MovieEntity> toggleFav;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            RatingIcon(iconColor: Colors.yellowAccent, rating: movie.rating),
            Text(movie.rating.toStringAsFixed(1))
          ],
        ),
        IconButton(
          icon:
              Icon(isFav.call(movie) ? Icons.favorite : Icons.favorite_border),
          color: Colors.red,
          onPressed: () => toggleFav.call(movie),
        ),
      ],
    );
  }
}
