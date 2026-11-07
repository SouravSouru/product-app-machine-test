import 'package:equatable/equatable.dart';

sealed class ProductDetailsEvent extends Equatable {
  const ProductDetailsEvent();

  @override
  List<Object?> get props => [];
}

final class ProductDetailsRefreshRequested extends ProductDetailsEvent {
  const ProductDetailsRefreshRequested();
}

final class ProductDetailsRetried extends ProductDetailsEvent {
  const ProductDetailsRetried();
}
