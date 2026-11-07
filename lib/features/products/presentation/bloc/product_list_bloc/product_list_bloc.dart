import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_app/features/products/domain/entities/product.dart';
import 'package:product_app/features/products/domain/entities/products_page.dart';
import 'package:product_app/features/products/domain/usecases/get_products.dart';
import 'package:product_app/features/products/presentation/bloc/product_list_bloc/product_list_event.dart';
import 'package:product_app/features/products/presentation/bloc/product_list_bloc/product_list_state.dart';

class ProductListBloc extends Bloc<ProductListEvent, ProductListState> {
  ProductListBloc(this._getProducts) : super(const ProductListInitial()) {
    on<ProductListFetched>(onFetched);
    on<ProductListRetried>(onFetched);
    on<ProductListRefreshed>(onRefreshed);
    on<ProductListLoadMoreRequested>(onLoadMore);
  }

  final GetProducts _getProducts;

  static const pageSize = 20;

  Future<void> onFetched(
    ProductListEvent event,
    Emitter<ProductListState> emit,
  ) async {
    emit(const ProductListLoading());
    final result = await _getProducts(limit: pageSize, skip: 0);
    if (isClosed) return;
    result.fold(
      (failure) => emit(ProductListError(failure.message)),
      (page) => emit(stateFor(page)),
    );
  }

  Future<void> onRefreshed(
    ProductListRefreshed event,
    Emitter<ProductListState> emit,
  ) async {
    final current = state;
    if (current is ProductListLoaded) {
      emit(current.copyWith(isRefreshing: true, isLoadingMore: false));
    } else {
      emit(const ProductListLoading());
    }

    final result = await _getProducts(limit: pageSize, skip: 0);
    if (isClosed) return;
    result.fold((failure) {
      if (current is ProductListLoaded) {
        emit(current.copyWith(isRefreshing: false, isLoadingMore: false));
        return;
      }
      emit(ProductListError(failure.message));
    }, (page) => emit(stateFor(page)));
  }

  Future<void> onLoadMore(
    ProductListLoadMoreRequested event,
    Emitter<ProductListState> emit,
  ) async {
    final current = state;
    if (current is! ProductListLoaded ||
        current.isLoadingMore ||
        current.isRefreshing ||
        !current.hasMore) {
      return;
    }

    emit(current.copyWith(isLoadingMore: true));
    final result = await _getProducts(
      limit: pageSize,
      skip: current.products.length,
    );
    if (isClosed) return;
    result.fold(
      (failure) => emit(current.copyWith(isLoadingMore: false)),
      (page) => emit(
        stateFor(
          page,
          previous: current.products,
          previousFromCache: current.fromCache,
        ),
      ),
    );
  }

  ProductListState stateFor(
    ProductsPage page, {
    List<Product> previous = const [],
    bool previousFromCache = false,
  }) {
    final products = [...previous, ...page.products];
    if (products.isEmpty) return const ProductListEmpty();

    final reachedEnd = page.products.isEmpty || !page.hasMore;
    return ProductListLoaded(
      products: products,
      hasMore: !reachedEnd,
      fromCache: previousFromCache || page.fromCache,
    );
  }
}
