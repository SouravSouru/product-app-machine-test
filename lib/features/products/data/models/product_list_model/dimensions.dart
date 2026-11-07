import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'dimensions.g.dart';

@JsonSerializable()
class Dimensions extends Equatable {
  final double? width;
  final double? height;
  final double? depth;

  const Dimensions({this.width, this.height, this.depth});

  factory Dimensions.fromJson(Map<String, dynamic> json) {
    return _$DimensionsFromJson(json);
  }

  Map<String, dynamic> toJson() => _$DimensionsToJson(this);

  @override
  List<Object?> get props => [width, height, depth];
}
