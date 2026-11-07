import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:product_app/features/products/domain/entities/products_page.dart';

import 'product.dart';

part 'product_list_model.g.dart';

@JsonSerializable()
class ProductListModel extends Equatable {
  final List<Product>? products;
  final int? total;
  final int? skip;
  final int? limit;

  const ProductListModel({this.products, this.total, this.skip, this.limit});

  factory ProductListModel.fromJson(Map<String, dynamic> json) {
    return _$ProductListModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ProductListModelToJson(this);

  ProductsPage toEntity({bool fromCache = false}) {
    return ProductsPage(
      products: [
        for (final product in products ?? const <Product>[]) product.toEntity(),
      ],
      total: total ?? 0,
      skip: skip ?? 0,
      limit: limit ?? 0,
      fromCache: fromCache,
    );
  }

  @override
  List<Object?> get props => [products, total, skip, limit];
}
