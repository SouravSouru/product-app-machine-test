import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_app/features/products/domain/entities/product.dart';
import 'package:product_app/features/products/domain/usecases/get_product_details.dart';
import 'package:product_app/features/products/presentation/bloc/product_details_bloc/product_details_event.dart';
import 'package:product_app/features/products/presentation/bloc/product_details_bloc/product_details_state.dart';

class ProductDetailsBloc
    extends Bloc<ProductDetailsEvent, ProductDetailsState> {
  ProductDetailsBloc(this._getProductDetails, Product product)
    : _productId = product.id,
      super(ProductDetailsLoaded(product)) {
    on<ProductDetailsRefreshRequested>(onRefresh);
    on<ProductDetailsRetried>(onRefresh);
    add(const ProductDetailsRefreshRequested());
  }

  final GetProductDetails _getProductDetails;
  final int _productId;

  Future<void> onRefresh(
    ProductDetailsEvent event,
    Emitter<ProductDetailsState> emit,
  ) async {
    final shown = state is ProductDetailsLoaded
        ? (state as ProductDetailsLoaded).product
        : null;
    if (shown == null) emit(const ProductDetailsLoading());

    final result = await _getProductDetails(_productId);
    if (isClosed) return;
    result.fold((failure) {
      if (shown != null) {
        emit(ProductDetailsLoaded(shown));
        return;
      }
      emit(ProductDetailsError(failure.message));
    }, (product) => emit(ProductDetailsLoaded(product)));
  }
}
