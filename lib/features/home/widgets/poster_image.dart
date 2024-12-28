import 'package:flutter/material.dart';
import 'package:movie_explorer/core/constants/api_routes.dart';
import 'package:movie_explorer/core/constants/lang_keys.dart';

class PosterImage extends StatelessWidget {
  const PosterImage({required this.posterImagePath, super.key});

  final String posterImagePath;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Image.network("${ApiRoutes.imageRoute}$posterImagePath",
          errorBuilder: (context, exception, stackTrace) {
        return Column(
          children: [
            const Icon(Icons.warning_amber, color: Colors.red, size: 40),
            Text(LangKeys.noImageFound)
          ],
        );
      }, loadingBuilder: (BuildContext context, Widget child,
              ImageChunkEvent? loadingProgress) {
        if (loadingProgress == null) return child;
        return Center(
          child: CircularProgressIndicator(
            value: loadingProgress.expectedTotalBytes != null
                ? loadingProgress.cumulativeBytesLoaded /
                    loadingProgress.expectedTotalBytes!
                : null,
          ),
        );
      }, width: double.infinity, fit: BoxFit.cover),
    );
  }
}
