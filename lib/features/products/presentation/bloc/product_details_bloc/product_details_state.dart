import 'package:equatable/equatable.dart';
import 'package:product_app/features/products/domain/entities/product.dart';

sealed class ProductDetailsState extends Equatable {
  const ProductDetailsState();
}

final class ProductDetailsInitial extends ProductDetailsState {
  const ProductDetailsInitial();

  @override
  List<Object?> get props => [];
}

final class ProductDetailsLoading extends ProductDetailsState {
  const ProductDetailsLoading();

  @override
  List<Object?> get props => [];
}

final class ProductDetailsLoaded extends ProductDetailsState {
  const ProductDetailsLoaded(this.product);

  final Product product;

  @override
  List<Object?> get props => [product];
}

final class ProductDetailsEmpty extends ProductDetailsState {
  const ProductDetailsEmpty();

  @override
  List<Object?> get props => [];
}

final class ProductDetailsError extends ProductDetailsState {
  const ProductDetailsError(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}
