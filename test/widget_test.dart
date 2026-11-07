import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:product_app/core/error/failure.dart';
import 'package:product_app/features/products/domain/entities/product.dart';
import 'package:product_app/features/products/domain/entities/products_page.dart';
import 'package:product_app/features/products/domain/repositories/product_repository.dart';
import 'package:product_app/features/products/domain/usecases/get_products.dart';
import 'package:product_app/features/products/presentation/bloc/product_list_bloc/product_list_bloc.dart';
import 'package:product_app/features/products/presentation/pages/profile_list/product_list_screen.dart';

void main() {
  testWidgets('shows the app title', (tester) async {
    final bloc = ProductListBloc(GetProducts(_EmptyProducts()));
    addTearDown(bloc.close);

    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider.value(value: bloc, child: const ProductListScreen()),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Products'), findsOneWidget);
  });

  testWidgets('shows one product', (tester) async {
    final bloc = ProductListBloc(GetProducts(_OneProduct()));
    addTearDown(bloc.close);

    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider.value(value: bloc, child: const ProductListScreen()),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Perfume'), findsOneWidget);
    expect(find.text('\$9.99'), findsOneWidget);
    expect(find.text('Beauty'), findsOneWidget);
    expect(find.text('4.5'), findsOneWidget);
  });
}

class _EmptyProducts implements ProductRepository {
  @override
  Future<Either<Failure, ProductsPage>> getProducts({
    required int limit,
    required int skip,
  }) async {
    return Right(
      ProductsPage(products: const [], total: 0, skip: skip, limit: limit),
    );
  }

  @override
  Future<Either<Failure, Product>> getProductDetails(int id) {
    throw UnimplementedError();
  }
}

class _OneProduct implements ProductRepository {
  @override
  Future<Either<Failure, ProductsPage>> getProducts({
    required int limit,
    required int skip,
  }) async {
    return Right(
      ProductsPage(
        products: const [
          Product(
            id: 1,
            title: 'Perfume',
            description: '',
            category: 'beauty',
            price: 9.99,
            discountPercentage: 0,
            rating: 4.5,
            stock: 10,
            brand: '',
            sku: '',
            warranty: '',
            shipping: '',
            returnPolicy: '',
            availabilityStatus: '',
            tags: [],
            thumbnail: '',
            images: [],
            reviews: [],
          ),
        ],
        total: 1,
        skip: skip,
        limit: limit,
      ),
    );
  }

  @override
  Future<Either<Failure, Product>> getProductDetails(int id) {
    throw UnimplementedError();
  }
}
