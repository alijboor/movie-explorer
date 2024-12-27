class BasePaginatedResponseEntity<R> {
  int? page;
  List<R?>? results;
  int? totalPages;
  int? totalResults;

  BasePaginatedResponseEntity(
      {this.page, this.results, this.totalPages, this.totalResults});

  factory BasePaginatedResponseEntity.fromJson(
    Map<String, dynamic> json,
    R Function(Map<String, dynamic>) fromJson,
  ) {
    return BasePaginatedResponseEntity<R>(
      page: json['page'],
      results: json['results'] != null
          ? List<R>.from(json['results'].map((v) => fromJson(v)))
          : null,
      totalPages: json['total_pages'],
      totalResults: json['total_results'],
    );
  }
}
