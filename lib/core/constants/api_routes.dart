class ApiRoutes {
  static const String _apiKey =
      "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJjOTQ5NmIzMGE5YTQ2Mjg5ODkzZWU3M2JmZTZjMmFkMiIsIm5iZiI6MTczNTIxMTE5My40Niwic3ViIjoiNjc2ZDM4YjlkMGIwOGY5NzE4NjEzZTY4Iiwic2NvcGVzIjpbImFwaV9yZWFkIl0sInZlcnNpb24iOjF9.neiG2ktIb1EGlTtCI0FZUmBgqKgAEaOd9uMrhunae70";

  static const String baseUrl = 'https://api.themoviedb.org/3';

  static const String movie = '$baseUrl/movie';
  static const String moviePopular = '$movie/popular?api_key=$_apiKey';

  static const String search = '$baseUrl/search';
  static const String movieSearch = '$search/movie?api_key=$_apiKey';
}
