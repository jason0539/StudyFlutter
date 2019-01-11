import 'package:json_annotation/json_annotation.dart';

part 'doubanresponse.g.dart';

@JsonSerializable()
class DoubanResponse {
  final int count;
  final int start;
  final int total;

  DoubanResponse(this.count, this.start, this.total);

  factory DoubanResponse.fromJson(Map<String, dynamic> json) =>
      _$DoubanResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DoubanResponseToJson(this);
}
