import 'package:equatable/equatable.dart';

sealed class ProductListEvent extends Equatable {
  const ProductListEvent();

  @override
  List<Object?> get props => [];
}

final class ProductListFetched extends ProductListEvent {
  const ProductListFetched();
}

final class ProductListLoadMoreRequested extends ProductListEvent {
  const ProductListLoadMoreRequested();
}

final class ProductListRefreshed extends ProductListEvent {
  const ProductListRefreshed();
}

final class ProductListRetried extends ProductListEvent {
  const ProductListRetried();
}
