import 'package:flutter/material.dart';
import 'package:movie_explorer/domain/entities/base_paginated_response_entity.dart';
import 'package:movie_explorer/domain/entities/movie_entity.dart';
import 'package:movie_explorer/domain/interfaces/movie_data_impl.dart';
import 'package:movie_explorer/features/home/providers/favorite_manager.dart';
import 'package:movie_explorer/features/home/screens/movie_details_screen.dart';

class HomeProvider with ChangeNotifier {
  final MovieRemoteDataSourceImpl repo = MovieRemoteDataSourceImpl();
  final FavoriteManager favManager;
  final TextEditingController searchController;

  ScrollController scrollController;

  List<MovieEntity> _movies;
  bool _isLoading;
  int _currentPage;
  bool _isFetchingMore;

  HomeProvider()
      : scrollController = ScrollController(),
        favManager = FavoriteManager(),
        _movies = [],
        _isLoading = false,
        _currentPage = 1,
        _isFetchingMore = false,
        searchController = TextEditingController() {
    _initData();
  }

  List<MovieEntity> get movies => _movies;

  bool get isLoading => _isLoading;
  bool get isFetchingMore => _isFetchingMore;

  Future<void> _initData() async {
    scrollController.addListener(_onScroll);
    await loadFav();
    _movies = await loadMovies(_currentPage);
  }

  Future<void> loadFav() async {
    await favManager.loadFavorites();
    notifyListeners();
  }

  Future<List<MovieEntity>> loadMovies(int page) async {
    _isLoading = true;
    notifyListeners();
    final BasePaginatedResponseEntity<MovieEntity>? paginated =
        await repo.fetchMovies(page);

    _isLoading = false;
    notifyListeners();
    return paginated?.results?.whereType<MovieEntity>().toList() ?? [];
  }

  Future<void> loadMoreMovies() async {
    if (_isFetchingMore) return;

    _isFetchingMore = true;
    _currentPage++;

    try {
      final newMovies = searchController.text.isEmpty
          ? await loadMovies(_currentPage)
          : (await repo.searchMovies(searchController.text, page: _currentPage))
                  ?.results
                  ?.whereType<MovieEntity>()
                  .toList() ??
              [];
      _movies.addAll(newMovies);
    } catch (e) {
      //TODO: error here
    }

    _isFetchingMore = false;
    notifyListeners();
  }

  void toggleFavState(MovieEntity movie) async {
    await favManager.toggleFavorite(movie);
    notifyListeners();
  }

  void _onScroll() async {
    if (scrollController.position.pixels >=
            scrollController.position.maxScrollExtent &&
        !isLoading) {
      await loadMoreMovies();
    }
  }

  void toDetailScreen(BuildContext context, MovieEntity movie) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MovieDetailsScreen(movie: movie),
      ),
    );
  }

  Future<void> searchMoviesByQuery(String query) async {
    _isLoading = true;
    notifyListeners();

    try {
      if (query.isEmpty) {
        clearSearch();
        return;
      }
      final searchedMovies = await repo.searchMovies(query, page: _currentPage);
      _movies =
          searchedMovies?.results?.whereType<MovieEntity>().toList() ?? [];
    } catch (e) {
      //TODO
    }

    _isLoading = false;
    notifyListeners();
  }

  void clearSearch() async {
    searchController.clear();
    _currentPage = 1;
    _movies = await loadMovies(_currentPage);
    notifyListeners();
  }

  @override
  void dispose() {
    scrollController.dispose();
    searchController.dispose();
    super.dispose();
  }
}
