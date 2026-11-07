import 'package:product_app/features/products/domain/entities/product.dart';

String productHeroTag(int id) => 'product-$id';

String categoryLabel(String value) {
  return value
      .split('-')
      .where((part) => part.isNotEmpty)
      .map((part) => '${part[0].toUpperCase()}${part.substring(1)}')
      .join(' ');
}

String stockLabel(Product product) {
  final status = product.availabilityStatus.trim();
  if (status.isNotEmpty) return status;
  if (product.stock <= 0) return 'Out of stock';
  if (product.stock <= 10) return 'Low stock';
  return 'In stock';
}
