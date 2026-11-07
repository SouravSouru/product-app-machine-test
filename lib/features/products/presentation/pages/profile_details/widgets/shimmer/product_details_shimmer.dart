import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ProductDetailsShimmer extends StatelessWidget {
  const ProductDetailsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: ListView(
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(12, 12, 12, 24),
        children: [
          box(height: 280, radius: 12),
          const SizedBox(height: 12),
          box(height: 22),
          const SizedBox(height: 8),
          box(width: 80, height: 14),
          const SizedBox(height: 14),
          box(width: 120, height: 20),
          const SizedBox(height: 20),
          box(width: 110, height: 16),
          const SizedBox(height: 10),
          box(height: 14),
          const SizedBox(height: 8),
          box(height: 14),
          const SizedBox(height: 8),
          box(width: 180, height: 14),
          const SizedBox(height: 20),
          box(height: 16),
          const SizedBox(height: 14),
          box(height: 16),
          const SizedBox(height: 14),
          box(height: 16),
        ],
      ),
    );
  }
}

Widget box({double? width, required double height, double radius = 8}) {
  return Container(
    width: width ?? double.infinity,
    height: height,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(radius),
    ),
  );
}
