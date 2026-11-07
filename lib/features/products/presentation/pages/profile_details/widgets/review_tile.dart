import 'package:flutter/material.dart';
import 'package:product_app/features/products/presentation/pages/profile_details/widgets/rating_badge.dart';
import 'package:product_app/features/products/domain/entities/review.dart';

class ReviewTile extends StatelessWidget {
  const ReviewTile({super.key, required this.review});

  final Review review;

  @override
  Widget build(BuildContext context) {
    final date = _shortDate(review.date);

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  review.reviewerName,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              RatingBadge(rating: review.rating),
            ],
          ),
          if (date.isNotEmpty) ...[
            const SizedBox(height: 2),
            Text(
              date,
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
          if (review.comment.isNotEmpty) ...[
            const SizedBox(height: 6),
            Text(review.comment, style: const TextStyle(fontSize: 14)),
          ],
        ],
      ),
    );
  }
}

String _shortDate(String value) {
  final separator = value.indexOf('T');
  if (separator <= 0) return value;
  return value.substring(0, separator);
}
