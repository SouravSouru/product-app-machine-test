import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:product_app/core/error/failure.dart';
import 'package:product_app/features/products/data/datasources/product_datasources.dart';
import 'package:product_app/features/products/data/datasources/products_local_source.dart';
import 'package:product_app/features/products/domain/entities/product.dart';
import 'package:product_app/features/products/domain/entities/products_page.dart';
import 'package:product_app/features/products/domain/repositories/product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  ProductRepositoryImpl(this._api, this._localSource);

  final ProductDatasources _api;
  final ProductsLocalSource _localSource;

  @override
  Future<Either<Failure, ProductsPage>> getProducts({
    required int limit,
    required int skip,
  }) async {
    try {
      final response = await _api.getProducts(limit: limit, skip: skip);

      await _localSource.savePage(skip, response);
      return Right(response.toEntity());
    } on DioException catch (error) {
      final cached = _localSource.readPage(skip)?.toEntity(fromCache: true);
      if (cached != null) return Right(cached);
      return Left(switch (error.type) {
        DioExceptionType.badResponse ||
        DioExceptionType.cancel => const ServerFailure(),
        _ => const NetworkFailure(),
      });
    } catch (_) {
      final cached = _localSource.readPage(skip)?.toEntity(fromCache: true);
      if (cached != null) return Right(cached);
      return const Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Product>> getProductDetails(int id) async {
    try {
      final response = await _api.getProduct(id);
      await _localSource.saveProduct(response);
      return Right(response.toEntity());
    } on DioException catch (error) {
      final cached = _localSource.readProduct(id)?.toEntity();
      if (cached != null) return Right(cached);
      return Left(switch (error.type) {
        DioExceptionType.badResponse ||
        DioExceptionType.cancel => const ServerFailure(),
        _ => const NetworkFailure(),
      });
    } catch (_) {
      final cached = _localSource.readProduct(id)?.toEntity();
      if (cached != null) return Right(cached);
      return const Left(ServerFailure());
    }
  }
}
