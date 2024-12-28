import 'package:flutter/material.dart';
import 'package:movie_explorer/domain/entities/movie_entity.dart';
import 'package:movie_explorer/domain/interfaces/movie_data_impl.dart';
import 'package:movie_explorer/features/home/providers/favorite_manager.dart';

class HomeProvider with ChangeNotifier {
  final MovieRemoteDataSourceImpl repo = MovieRemoteDataSourceImpl();
  final FavoriteManager favManager;
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
        _isFetchingMore = false {
    _initData();
  }

  List<MovieEntity> get movies => _movies;

  bool get isLoading => _isLoading;
  bool get isFetchingMore => _isFetchingMore;

  Future<void> _initData() async {
    scrollController.addListener(_onScroll);
    await loadFav();
    await loadMovies(_currentPage);
  }

  Future<void> loadFav() async {
    await favManager.loadFavorites();
    notifyListeners();
  }

  Future<void> loadMovies(int page) async {
    _isLoading = true;
    notifyListeners();

    try {
      final paginated = await repo.fetchMovies(page);
      final list = paginated.results?.whereType<MovieEntity>().toList() ?? [];
      _movies = list;
    } catch (e) {
      //TODO: error here
      print(e);
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> loadMoreMovies() async {
    if (_isFetchingMore) return;

    _isFetchingMore = true;
    _currentPage++;

    try {
      final res = await repo.fetchMovies(_currentPage);
      final newMovies = res.results?.whereType<MovieEntity>().toList() ?? [];
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

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
}
