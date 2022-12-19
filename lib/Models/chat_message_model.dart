class ChatMessageModel {
  int? id;
  String? content;
  String? time;
  DateTime? date;
  bool? isMe;

  ChatMessageModel({this.id, this.content, this.time, this.date, this.isMe});
}
