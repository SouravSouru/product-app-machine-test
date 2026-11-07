import 'package:dartz/dartz.dart';
import 'package:product_app/core/error/failure.dart';
import 'package:product_app/features/products/domain/entities/product.dart';
import 'package:product_app/features/products/domain/repositories/product_repository.dart';

class GetProductDetails {
  const GetProductDetails(this._repository);

  final ProductRepository _repository;

  Future<Either<Failure, Product>> call(int id) {
    return _repository.getProductDetails(id);
  }
}
