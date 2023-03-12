class MessageModel {
  MessageModel({
    required this.id,
    required this.title,
    required this.description,
    required this.createdAt,
    required this.status,
  });
  String id;
  String title;
  String description;
  String createdAt;
  String status;
  factory MessageModel.fromJson(Map<String, dynamic> json) => MessageModel(
      id: json["_id"],
      title: json["title"],
      description: json["description"],
      createdAt: json["createdAt"],
      status: json["status"]
  );
}