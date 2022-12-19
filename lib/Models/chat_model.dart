class ChatModel {
  int? id;
  String? name;
  String? username;
  String? lastMessageDate;
  String? lastMessage;
  String? avatarURL;

  ChatModel(
      {this.id,
      this.name,
      this.username,
      this.lastMessage,
      this.lastMessageDate,
      this.avatarURL});
}
