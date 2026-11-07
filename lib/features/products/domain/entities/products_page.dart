import 'package:equatable/equatable.dart';
import 'package:product_app/features/products/domain/entities/product.dart';

class ProductsPage extends Equatable {
  const ProductsPage({
    required this.products,
    required this.total,
    required this.skip,
    required this.limit,
    this.fromCache = false,
  });

  final List<Product> products;
  final int total;
  final int skip;
  final int limit;
  final bool fromCache;

  bool get hasMore => skip + products.length < total;

  @override
  List<Object?> get props => [products, total, skip, limit, fromCache];
}
