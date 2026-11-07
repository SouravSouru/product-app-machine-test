import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:product_app/features/products/domain/entities/review.dart'
    as entity;

part 'review.g.dart';

@JsonSerializable()
class Review extends Equatable {
  final int? rating;
  final String? comment;
  final DateTime? date;
  final String? reviewerName;
  final String? reviewerEmail;

  const Review({
    this.rating,
    this.comment,
    this.date,
    this.reviewerName,
    this.reviewerEmail,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return _$ReviewFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ReviewToJson(this);

  entity.Review toEntity() {
    return entity.Review(
      rating: (rating ?? 0).toDouble(),
      comment: comment ?? '',
      date: date?.toIso8601String() ?? '',
      reviewerName: reviewerName ?? '',
    );
  }

  @override
  List<Object?> get props {
    return [rating, comment, date, reviewerName, reviewerEmail];
  }
}
