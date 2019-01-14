// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movieresponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieResponse _$MovieResponseFromJson(Map<String, dynamic> json) {
  return MovieResponse(
      json['year'] as String,
      json['images'] == null
          ? null
          : DImages.fromJson(json['images'] as Map<String, dynamic>),
      json['title'] as String,
      json['summary'] as String);
}

Map<String, dynamic> _$MovieResponseToJson(MovieResponse instance) =>
    <String, dynamic>{
      'year': instance.year,
      'images': instance.images,
      'title': instance.title,
      'summary': instance.summary
    };
