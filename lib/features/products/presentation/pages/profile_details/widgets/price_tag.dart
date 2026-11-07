import 'package:flutter/material.dart';

class PriceTag extends StatelessWidget {
  const PriceTag({super.key, required this.price, this.discountPercentage});

  final double price;
  final double? discountPercentage;

  @override
  Widget build(BuildContext context) {
    final discount = discountPercentage ?? 0;
    return Row(
      children: [
        Text(
          money(price),
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
        if (discount > 0) ...[
          const SizedBox(width: 6),
          Flexible(
            child: Text(
              '${percent(discount)}% off',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Colors.green,
              ),
            ),
          ),
        ],
      ],
    );
  }
}

String money(double value) => '\$${value.toStringAsFixed(2)}';

String percent(double value) {
  final fixed = value.toStringAsFixed(2);
  return fixed.replaceAll(RegExp(r'\.?0+$'), '');
}
