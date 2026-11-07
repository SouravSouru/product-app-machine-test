import 'package:flutter/material.dart';
import 'package:product_app/features/products/presentation/pages/profile_details/widgets/image_gallery.dart';
import 'package:product_app/features/products/presentation/pages/profile_details/widgets/info_row.dart';
import 'package:product_app/features/products/presentation/pages/profile_details/widgets/price_tag.dart';
import 'package:product_app/features/products/presentation/pages/profile_details/widgets/rating_badge.dart';
import 'package:product_app/features/products/domain/entities/product.dart';
import 'package:product_app/features/products/presentation/pages/profile_details/widgets/review_tile.dart';
import 'package:product_app/features/products/presentation/product_labels.dart';

class ProductDetailsBody extends StatelessWidget {
  const ProductDetailsBody({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    final details = <MapEntry<String, String>>[
      if (product.brand.isNotEmpty) MapEntry('Brand', product.brand),
      MapEntry('Stock', '${stockLabel(product)} · ${product.stock}'),
      if (product.sku.isNotEmpty) MapEntry('SKU', product.sku),
      if (product.warranty.isNotEmpty) MapEntry('Warranty', product.warranty),
      if (product.shipping.isNotEmpty) MapEntry('Shipping', product.shipping),
      if (product.returnPolicy.isNotEmpty)
        MapEntry('Returns', product.returnPolicy),
    ];

    return ListView(
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 24),
      children: [
        ImageGallery(
          imageUrls: product.gallery,
          heroTag: productHeroTag(product.id),
        ),
        const SizedBox(height: 12),
        section(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                product.title,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                ),
              ),
              if (product.category.isNotEmpty) ...[
                const SizedBox(height: 4),
                Text(
                  categoryLabel(product.category),
                  style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
                ),
              ],
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: PriceTag(
                      price: product.price,
                      discountPercentage: product.discountPercentage,
                    ),
                  ),
                  const SizedBox(width: 12),
                  RatingBadge(rating: product.rating),
                ],
              ),
            ],
          ),
        ),
        if (product.description.isNotEmpty) ...[
          const SizedBox(height: 12),
          section(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Description',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 8),
                Text(
                  product.description,
                  style: const TextStyle(fontSize: 15, height: 1.4),
                ),
              ],
            ),
          ),
        ],
        const SizedBox(height: 12),
        section(
          child: Column(
            children: [
              for (var i = 0; i < details.length; i++) ...[
                InfoRow(label: details[i].key, value: details[i].value),
                if (i != details.length - 1)
                  Divider(height: 1, color: Colors.grey.shade200),
              ],
            ],
          ),
        ),
        if (product.tags.isNotEmpty) ...[
          const SizedBox(height: 16),
          const Text(
            'Tags',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final tag in product.tags)
                DecoratedBox(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    child: Text(
                      categoryLabel(tag),
                      style: const TextStyle(fontSize: 13),
                    ),
                  ),
                ),
            ],
          ),
        ],
        if (product.reviews.isNotEmpty) ...[
          const SizedBox(height: 16),
          const Text(
            'Reviews',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          for (final review in product.reviews) ReviewTile(review: review),
        ],
      ],
    );
  }
}

Widget section({required Widget child}) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: child,
  );
}
