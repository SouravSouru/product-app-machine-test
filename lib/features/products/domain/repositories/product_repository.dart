import 'package:dartz/dartz.dart';
import 'package:product_app/core/error/failure.dart';
import 'package:product_app/features/products/domain/entities/product.dart';
import 'package:product_app/features/products/domain/entities/products_page.dart';

abstract class ProductRepository {
  Future<Either<Failure, ProductsPage>> getProducts({
    required int limit,
    required int skip,
  });

  Future<Either<Failure, Product>> getProductDetails(int id);
}
