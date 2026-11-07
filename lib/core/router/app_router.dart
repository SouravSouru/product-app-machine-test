import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:product_app/core/di/injection.dart';
import 'package:product_app/core/widgets/empty_view.dart';
import 'package:product_app/features/products/domain/entities/product.dart';
import 'package:product_app/features/products/presentation/bloc/product_details_bloc/product_details_bloc.dart';
import 'package:product_app/features/products/presentation/bloc/product_list_bloc/product_list_bloc.dart';
import 'package:product_app/features/products/presentation/pages/profile_details/product_details_screen.dart';
import 'package:product_app/features/products/presentation/pages/profile_list/product_list_screen.dart';
import 'package:product_app/core/router/app_routes.dart';
import 'package:product_app/features/splash/presentation/splash_screen.dart';

final appRouter = GoRouter(
  initialLocation: AppRoutes.splash,
  routes: [
    GoRoute(
      path: AppRoutes.splash,
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: AppRoutes.products,
      builder: (context, state) {
        return BlocProvider(
          create: (_) => getIt<ProductListBloc>(),
          child: const ProductListScreen(),
        );
      },
      routes: [
        GoRoute(
          path: ':id',
          builder: (context, state) {
            final product = state.extra;
            if (product is! Product) {
              return const Scaffold(
                body: EmptyView(message: 'Product not found'),
              );
            }

            return BlocProvider(
              create: (_) => getIt<ProductDetailsBloc>(param1: product),
              child: const ProductDetailsScreen(),
            );
          },
        ),
      ],
    ),
  ],
);
