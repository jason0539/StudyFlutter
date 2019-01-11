// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'doubanresponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DoubanResponse _$DoubanResponseFromJson(Map<String, dynamic> json) {
  return DoubanResponse(
      json['count'] as int, json['start'] as int, json['total'] as int);
}

Map<String, dynamic> _$DoubanResponseToJson(DoubanResponse instance) =>
    <String, dynamic>{
      'count': instance.count,
      'start': instance.start,
      'total': instance.total
    };
