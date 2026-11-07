import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:product_app/core/router/app_routes.dart';
import 'package:product_app/features/products/presentation/pages/profile_list/widgets/product_card.dart';
import 'package:product_app/features/products/presentation/pages/profile_list/widgets/shimmer/product_list_shimmer.dart';
import 'package:product_app/features/products/presentation/bloc/product_list_bloc/product_list_state.dart';
import 'package:product_app/features/products/presentation/product_labels.dart';

class ProductList extends StatelessWidget {
  const ProductList({super.key, required this.state, required this.controller});

  final ProductListLoaded state;
  final ScrollController controller;

  @override
  Widget build(BuildContext context) {
    final products = state.products;
    final itemCount = products.length + (state.isLoadingMore ? 1 : 0);

    return GridView.builder(
      controller: controller,
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 24),
      itemCount: itemCount,
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 220,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.62,
      ),
      itemBuilder: (context, index) {
        if (index >= products.length) {
          return const ProductCardShimmer();
        }

        final product = products[index];
        return ProductCard(
          key: ValueKey(product.id),
          title: product.title,
          price: product.price,
          discountPercentage: product.discountPercentage,
          category: categoryLabel(product.category),
          rating: product.rating,
          imageUrl: product.thumbnail.isEmpty ? null : product.thumbnail,
          heroTag: productHeroTag(product.id),
          onTap: () {
            // passing the product data to the details screen is to load the scren fastly, details api will call parallel to get nrw data and update the state
            context.push(AppRoutes.productDetails(product.id), extra: product);
          },
        );
      },
    );
  }
}
