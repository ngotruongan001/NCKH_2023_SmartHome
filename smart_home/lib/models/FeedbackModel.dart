import 'dart:convert';

FeedbackModel FeedbackModelFromJson(String str) => FeedbackModel.fromJson(json.decode(str));
String FeedbackModelToJson(FeedbackModel data) => json.encode(data.toJson());

class FeedbackModel {
  String description;

  FeedbackModel({
    required this.description,
  });

  factory FeedbackModel.fromJson(Map<String, dynamic> json) => FeedbackModel(
    description: json["description"],
  );

  Map<String, dynamic> toJson() => {
    "description": description,
  };
}