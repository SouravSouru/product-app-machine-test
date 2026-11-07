import 'package:get_it/get_it.dart';
import 'package:product_app/core/network/api_client.dart';
import 'package:product_app/features/products/data/datasources/product_datasources.dart';
import 'package:product_app/features/products/data/datasources/products_local_source.dart';
import 'package:product_app/features/products/data/repositories/product_repository_impl.dart';
import 'package:product_app/features/products/domain/entities/product.dart';
import 'package:product_app/features/products/domain/repositories/product_repository.dart';
import 'package:product_app/features/products/domain/usecases/get_product_details.dart';
import 'package:product_app/features/products/domain/usecases/get_products.dart';
import 'package:product_app/features/products/presentation/bloc/product_details_bloc/product_details_bloc.dart';
import 'package:product_app/features/products/presentation/bloc/product_list_bloc/product_list_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

Future<void> configureDependencies() async {
  final preferences = await SharedPreferences.getInstance();
  getIt.registerSingleton<SharedPreferences>(preferences);

  getIt.registerLazySingleton(ApiClient.new);
  getIt.registerLazySingleton<ProductDatasources>(
    () => ProductDatasources(getIt<ApiClient>().dio),
  );
  getIt.registerLazySingleton<ProductsLocalSource>(
    () => ProductsLocalSource(getIt<SharedPreferences>()),
  );
  getIt.registerLazySingleton<ProductRepository>(
    () => ProductRepositoryImpl(
      getIt<ProductDatasources>(),
      getIt<ProductsLocalSource>(),
    ),
  );
  getIt.registerLazySingleton(() => GetProducts(getIt<ProductRepository>()));
  getIt.registerLazySingleton(
    () => GetProductDetails(getIt<ProductRepository>()),
  );
  getIt.registerFactory(() => ProductListBloc(getIt<GetProducts>()));
  getIt.registerFactoryParam<ProductDetailsBloc, Product, Object?>(
    (product, _) => ProductDetailsBloc(getIt<GetProductDetails>(), product),
  );
}
