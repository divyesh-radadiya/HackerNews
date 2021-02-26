// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewsModel _$NewsModelFromJson(Map<String, dynamic> json) {
  return NewsModel(
    by: json['by'] as String,
    id: json['id'] as int,
    time: json['time'] as int,
    title: json['title'] as String,
  );
}

Map<String, dynamic> _$NewsModelToJson(NewsModel instance) => <String, dynamic>{
      'by': instance.by,
      'title': instance.title,
      'time': instance.time,
      'id': instance.id,
    };
