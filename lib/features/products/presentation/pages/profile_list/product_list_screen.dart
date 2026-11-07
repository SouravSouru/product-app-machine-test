import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_app/core/widgets/empty_view.dart';
import 'package:product_app/core/widgets/error_view.dart';
import 'package:product_app/features/products/presentation/bloc/product_list_bloc/product_list_bloc.dart';
import 'package:product_app/features/products/presentation/bloc/product_list_bloc/product_list_event.dart';
import 'package:product_app/features/products/presentation/bloc/product_list_bloc/product_list_state.dart';
import 'package:product_app/features/products/presentation/pages/profile_list/widgets/product_list.dart';
import 'package:product_app/features/products/presentation/pages/profile_list/widgets/shimmer/product_list_shimmer.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  final scrollController = ScrollController();
  var loadMoreQueued = false;

  @override
  void initState() {
    super.initState();
    context.read<ProductListBloc>().add(const ProductListFetched());
    scrollController.addListener(onScroll);
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  void onScroll() {
    if (loadMoreQueued || !scrollController.hasClients) return;
    if (scrollController.position.extentAfter > 280) return;

    final state = context.read<ProductListBloc>().state;
    if (state is! ProductListLoaded || state.isLoadingMore || !state.hasMore) {
      return;
    }

    loadMoreQueued = true;
    context.read<ProductListBloc>().add(const ProductListLoadMoreRequested());
  }

  Future<void> refresh() {
    final bloc = context.read<ProductListBloc>();
    final done = bloc.stream.firstWhere((state) {
      return switch (state) {
        ProductListLoaded(:final isRefreshing) => !isRefreshing,
        ProductListEmpty() || ProductListError() => true,
        _ => false,
      };
    });
    bloc.add(const ProductListRefreshed());
    return done;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(title: const Text('Products')),
      body: BlocConsumer<ProductListBloc, ProductListState>(
        listenWhen: (previous, current) {
          return previous is ProductListLoaded &&
              previous.isLoadingMore &&
              current is ProductListLoaded &&
              !current.isLoadingMore;
        },
        listener: (context, state) {
          loadMoreQueued = false;
        },
        builder: (context, state) {
          return switch (state) {
            ProductListInitial() ||
            ProductListLoading() => const ProductListShimmer(),
            ProductListEmpty() => RefreshIndicator(
              onRefresh: refresh,
              child: ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                children: const [
                  SizedBox(
                    height: 360,
                    child: EmptyView(message: 'No products found'),
                  ),
                ],
              ),
            ),
            ProductListError(:final message) => ErrorView(
              message: message,
              onRetry: () {
                context.read<ProductListBloc>().add(const ProductListRetried());
              },
            ),
            ProductListLoaded() => RefreshIndicator(
              onRefresh: refresh,
              child: ProductList(state: state, controller: scrollController),
            ),
          };
        },
      ),
    );
  }
}
