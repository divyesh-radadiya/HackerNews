import 'package:json_annotation/json_annotation.dart';

part 'news_model.g.dart';

@JsonSerializable(nullable: false)
class NewsModel {
  final String by;
  final String title;
  final int time;
  final int id;

  NewsModel({this.by, this.id, this.time, this.title});
  factory NewsModel.fromJson(Map<String, dynamic> json) =>
      _$NewsModelFromJson(json);
  Map<String, dynamic> toJson() => _$NewsModelToJson(this);
}
