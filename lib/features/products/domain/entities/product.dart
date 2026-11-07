import 'package:equatable/equatable.dart';
import 'package:product_app/features/products/domain/entities/review.dart';

class Product extends Equatable {
  const Product({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.price,
    required this.discountPercentage,
    required this.rating,
    required this.stock,
    required this.brand,
    required this.sku,
    required this.warranty,
    required this.shipping,
    required this.returnPolicy,
    required this.availabilityStatus,
    required this.tags,
    required this.thumbnail,
    required this.images,
    required this.reviews,
  });

  final int id;
  final String title;
  final String description;
  final String category;
  final double price;
  final double discountPercentage;
  final double rating;
  final int stock;
  final String brand;
  final String sku;
  final String warranty;
  final String shipping;
  final String returnPolicy;
  final String availabilityStatus;
  final List<String> tags;
  final String thumbnail;
  final List<String> images;
  final List<Review> reviews;

  List<String> get gallery {
    if (images.isNotEmpty) return images;
    if (thumbnail.isEmpty) return const [];
    return [thumbnail];
  }

  @override
  List<Object?> get props => [
    id,
    title,
    description,
    category,
    price,
    discountPercentage,
    rating,
    stock,
    brand,
    sku,
    warranty,
    shipping,
    returnPolicy,
    availabilityStatus,
    tags,
    thumbnail,
    images,
    reviews,
  ];
}
