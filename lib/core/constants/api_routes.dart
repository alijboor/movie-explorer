class ApiRoutes {
  static const String _apiKey =
      "c9496b30a9a46289893ee73bfe6c2ad2";

  static const String baseUrl = 'https://api.themoviedb.org/3';
  static const String imageRoute = 'https://image.tmdb.org/t/p/w400';

  static const String movie = '$baseUrl/movie';
  static const String moviePopular = '$movie/popular?api_key=$_apiKey';

  static const String search = '$baseUrl/search';
  static const String movieSearch = '$search/movie?api_key=$_apiKey';
}
