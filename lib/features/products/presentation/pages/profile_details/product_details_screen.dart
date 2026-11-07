import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_app/core/widgets/empty_view.dart';
import 'package:product_app/core/widgets/error_view.dart';
import 'package:product_app/features/products/presentation/bloc/product_details_bloc/product_details_bloc.dart';
import 'package:product_app/features/products/presentation/bloc/product_details_bloc/product_details_event.dart';
import 'package:product_app/features/products/presentation/bloc/product_details_bloc/product_details_state.dart';
import 'package:product_app/features/products/presentation/pages/profile_details/widgets/product_details_body.dart';
import 'package:product_app/features/products/presentation/pages/profile_details/widgets/shimmer/product_details_shimmer.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductDetailsBloc, ProductDetailsState>(
      builder: (context, state) {
        final title = switch (state) {
          ProductDetailsLoaded(:final product) => product.title,
          _ => 'Product',
        };

        return Scaffold(
          backgroundColor: Colors.grey.shade100,
          appBar: AppBar(
            title: Text(title, maxLines: 1, overflow: TextOverflow.ellipsis),
          ),
          body: switch (state) {
            ProductDetailsInitial() ||
            ProductDetailsLoading() => const ProductDetailsShimmer(),
            ProductDetailsEmpty() => const EmptyView(
              message: 'Product not found',
            ),
            ProductDetailsError(:final message) => ErrorView(
              message: message,
              onRetry: () {
                context.read<ProductDetailsBloc>().add(
                  const ProductDetailsRetried(),
                );
              },
            ),
            ProductDetailsLoaded(:final product) => ProductDetailsBody(
              product: product,
            ),
          },
        );
      },
    );
  }
}
