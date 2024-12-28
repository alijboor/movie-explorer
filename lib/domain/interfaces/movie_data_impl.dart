import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movie_explorer/core/constants/api_routes.dart';
import 'package:movie_explorer/core/services/dialog_service.dart';
import 'package:movie_explorer/domain/entities/base_paginated_response_entity.dart';

import 'package:movie_explorer/domain/entities/movie_entity.dart';
import 'package:movie_explorer/domain/interfaces/movie_interface.dart';

class MovieRemoteDataSourceImpl implements MovieInterface {
  final http.Client client;

  MovieRemoteDataSourceImpl() : client = http.Client();

  @override
  Future<BasePaginatedResponseEntity<MovieEntity>?> fetchMovies(
      int page) async {
    final response =
        await client.get(Uri.parse('${ApiRoutes.moviePopular}&page=$page'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return BasePaginatedResponseEntity<MovieEntity>.fromJson(
        data,
        (movie) => MovieEntity.fromJson(movie),
      );
    }
    DialogService().showErrorDialog(response.reasonPhrase ?? '');
    return null;
  }

  @override
  Future<BasePaginatedResponseEntity<MovieEntity>?> searchMovies(String query,
      {int? page}) async {
    final response = await client
        .get(Uri.parse('${ApiRoutes.movieSearch}&query=$query&page=$page'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return BasePaginatedResponseEntity<MovieEntity>.fromJson(
        data,
        (movie) => MovieEntity.fromJson(movie),
      );
    }
    DialogService().showErrorDialog(response.reasonPhrase ?? '');
    return null;
  }
}
