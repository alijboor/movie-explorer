import 'package:flutter/material.dart';

class RatingIcon extends StatelessWidget {
  final double size;
  final Color iconColor;
  final double rating;

  const RatingIcon(
      {super.key,
      this.size = 24,
      required this.iconColor,
      required this.rating});

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcATop,
      shaderCallback: (Rect rect) {
        return LinearGradient(
          stops: [0, rating / 10, rating / 10],
          colors: [iconColor, iconColor, iconColor.withOpacity(0)],
        ).createShader(rect);
      },
      child: SizedBox(
        width: size,
        height: size,
        child: Icon(Icons.star, size: size, color: Colors.grey.shade300),
      ),
    );
  }
}
