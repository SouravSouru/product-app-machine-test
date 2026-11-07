import 'package:dio/dio.dart';
import 'package:product_app/features/products/data/models/product_details_model/product_details_model.dart';
import 'package:product_app/features/products/data/models/product_list_model/product_list_model.dart';
import 'package:retrofit/retrofit.dart';

part 'product_datasources.g.dart';

@RestApi()
abstract class ProductDatasources {
  factory ProductDatasources(Dio dio) => _ProductDatasources(dio);

  @GET('/products')
  Future<ProductListModel> getProducts({
    @Query('limit') required int limit,
    @Query('skip') required int skip,
  });

  @GET('/products/{id}')
  Future<ProductDetailsModel> getProduct(@Path('id') int id);
}
