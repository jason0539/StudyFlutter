// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'doubanresponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DImages _$DImagesFromJson(Map<String, dynamic> json) {
  return DImages(json['small'] as String, json['large'] as String,
      json['medium'] as String);
}

Map<String, dynamic> _$DImagesToJson(DImages instance) => <String, dynamic>{
      'small': instance.small,
      'large': instance.large,
      'medium': instance.medium
    };

DMovie _$DMovieFromJson(Map<String, dynamic> json) {
  return DMovie(
      json['title'] as String,
      json['year'] as String,
      json['images'] == null
          ? null
          : DImages.fromJson(json['images'] as Map<String, dynamic>),
      json['id'] as String);
}

Map<String, dynamic> _$DMovieToJson(DMovie instance) => <String, dynamic>{
      'title': instance.title,
      'year': instance.year,
      'images': instance.images,
      'id': instance.id
    };

DoubanResponse _$DoubanResponseFromJson(Map<String, dynamic> json) {
  return DoubanResponse(
      json['count'] as int,
      json['start'] as int,
      json['total'] as int,
      (json['subjects'] as List)
          ?.map((e) =>
              e == null ? null : DMovie.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$DoubanResponseToJson(DoubanResponse instance) =>
    <String, dynamic>{
      'count': instance.count,
      'start': instance.start,
      'total': instance.total,
      'subjects': instance.movies
    };
