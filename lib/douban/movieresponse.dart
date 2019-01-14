import 'package:json_annotation/json_annotation.dart';

import 'package:flutter_app/douban/doubanresponse.dart';

part 'movieresponse.g.dart';

@JsonSerializable()
class MovieResponse {
  final String year;

  final DImages images;

  final String title;

  final String summary;

  MovieResponse(this.year, this.images, this.title, this.summary);

  factory MovieResponse.fromJson(Map<String, dynamic> json) =>
      _$MovieResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MovieResponseToJson(this);
}
