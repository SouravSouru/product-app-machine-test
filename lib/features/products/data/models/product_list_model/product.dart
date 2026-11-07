import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:product_app/features/products/domain/entities/product.dart'
    as entity;

import 'dimensions.dart';
import 'meta.dart';
import 'review.dart';

part 'product.g.dart';

@JsonSerializable()
class Product extends Equatable {
  final int? id;
  final String? title;
  final String? description;
  final String? category;
  final double? price;
  final double? discountPercentage;
  final double? rating;
  final int? stock;
  final List<String>? tags;
  final String? brand;
  final String? sku;
  final int? weight;
  final Dimensions? dimensions;
  final String? warrantyInformation;
  final String? shippingInformation;
  final String? availabilityStatus;
  final List<Review>? reviews;
  final String? returnPolicy;
  final int? minimumOrderQuantity;
  final Meta? meta;
  final List<String>? images;
  final String? thumbnail;

  const Product({
    this.id,
    this.title,
    this.description,
    this.category,
    this.price,
    this.discountPercentage,
    this.rating,
    this.stock,
    this.tags,
    this.brand,
    this.sku,
    this.weight,
    this.dimensions,
    this.warrantyInformation,
    this.shippingInformation,
    this.availabilityStatus,
    this.reviews,
    this.returnPolicy,
    this.minimumOrderQuantity,
    this.meta,
    this.images,
    this.thumbnail,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return _$ProductFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ProductToJson(this);

  entity.Product toEntity() {
    return entity.Product(
      id: id ?? 0,
      title: title ?? '',
      description: description ?? '',
      category: category ?? '',
      price: price ?? 0,
      discountPercentage: discountPercentage ?? 0,
      rating: rating ?? 0,
      stock: stock ?? 0,
      brand: brand ?? '',
      sku: sku ?? '',
      warranty: warrantyInformation ?? '',
      shipping: shippingInformation ?? '',
      returnPolicy: returnPolicy ?? '',
      availabilityStatus: availabilityStatus ?? '',
      tags: tags ?? const [],
      thumbnail: thumbnail ?? '',
      images: images ?? const [],
      reviews: [
        for (final review in reviews ?? const <Review>[]) review.toEntity(),
      ],
    );
  }

  @override
  List<Object?> get props {
    return [
      id,
      title,
      description,
      category,
      price,
      discountPercentage,
      rating,
      stock,
      tags,
      brand,
      sku,
      weight,
      dimensions,
      warrantyInformation,
      shippingInformation,
      availabilityStatus,
      reviews,
      returnPolicy,
      minimumOrderQuantity,
      meta,
      images,
      thumbnail,
    ];
  }
}
