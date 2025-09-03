class PaginationState {
  final int page;
  final bool hasMore;
  final String? sort;
  final String? search;

  PaginationState({this.page = 1, this.hasMore = true, this.sort, this.search});

  PaginationState copyWith({
    int? page,
    bool? hasMore,
    String? sort,
    String? search,
  }) {
    return PaginationState(
      page: page ?? this.page,
      hasMore: hasMore ?? this.hasMore,
      sort: sort ?? this.sort,
      search: search ?? this.search,
    );
  }

  @override
  String toString() {
    return '$page, $hasMore, $sort, $search';
  }
}
