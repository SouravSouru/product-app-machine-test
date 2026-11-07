import 'package:dartz/dartz.dart';
import 'package:product_app/core/error/failure.dart';
import 'package:product_app/features/products/domain/entities/products_page.dart';
import 'package:product_app/features/products/domain/repositories/product_repository.dart';

class GetProducts {
  const GetProducts(this._repository);

  final ProductRepository _repository;

  Future<Either<Failure, ProductsPage>> call({
    required int limit,
    required int skip,
  }) {
    return _repository.getProducts(limit: limit, skip: skip);
  }
}
