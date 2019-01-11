import 'package:json_annotation/json_annotation.dart';

part 'doubanresponse.g.dart';

@JsonSerializable()
class DImages {
  @JsonKey(name: "small")
  final String small;
  final String large;
  final String medium;

  DImages(this.small, this.large, this.medium);

  factory DImages.fromJson(Map<String, dynamic> json) =>
      _$DImagesFromJson(json);

  Map<String, dynamic> toJson() => _$DImagesToJson(this);
}

@JsonSerializable()
class DMovie {
  final String title;
  final String year;
  final DImages images;
  final String id;

  DMovie(this.title, this.year, this.images, this.id);

  factory DMovie.fromJson(Map<String, dynamic> json) => _$DMovieFromJson(json);

  Map<String, dynamic> toJson() => _$DMovieToJson(this);
}

@JsonSerializable()
class DoubanResponse {
  final int count;
  final int start;
  final int total;
  @JsonKey(name: "subjects")
  final List<DMovie> movies;

  DoubanResponse(this.count, this.start, this.total, this.movies);

  factory DoubanResponse.fromJson(Map<String, dynamic> json) =>
      _$DoubanResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DoubanResponseToJson(this);
}
