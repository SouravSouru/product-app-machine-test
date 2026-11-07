import 'package:equatable/equatable.dart';
import 'package:product_app/features/products/domain/entities/product.dart';

sealed class ProductListState extends Equatable {
  const ProductListState();
}

final class ProductListInitial extends ProductListState {
  const ProductListInitial();

  @override
  List<Object?> get props => [];
}

final class ProductListLoading extends ProductListState {
  const ProductListLoading();

  @override
  List<Object?> get props => [];
}

final class ProductListLoaded extends ProductListState {
  const ProductListLoaded({
    required this.products,
    required this.hasMore,
    required this.fromCache,
    this.isLoadingMore = false,
    this.isRefreshing = false,
  });

  final List<Product> products;
  final bool hasMore;
  final bool fromCache;
  final bool isLoadingMore;
  final bool isRefreshing;

  ProductListLoaded copyWith({
    List<Product>? products,
    bool? hasMore,
    bool? fromCache,
    bool? isLoadingMore,
    bool? isRefreshing,
  }) {
    return ProductListLoaded(
      products: products ?? this.products,
      hasMore: hasMore ?? this.hasMore,
      fromCache: fromCache ?? this.fromCache,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      isRefreshing: isRefreshing ?? this.isRefreshing,
    );
  }

  @override
  List<Object?> get props => [
    products,
    hasMore,
    fromCache,
    isLoadingMore,
    isRefreshing,
  ];
}

final class ProductListEmpty extends ProductListState {
  const ProductListEmpty();

  @override
  List<Object?> get props => [];
}

final class ProductListError extends ProductListState {
  const ProductListError(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}
