class ChatModel {
  int? id;
  String? name;
  String? username;
  String? lastMessageDate;
  String? lastMessage;
  int? lastMessageID;
  String? avatarURL;
  int? unReadCount;

  ChatModel(
      {this.id,
      this.name,
      this.username,
      this.unReadCount,
      this.lastMessage,
      this.lastMessageDate,
      this.lastMessageID,
      this.avatarURL});

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "username": username,
      "lastMessageDate": lastMessageDate,
      "lastMessage": lastMessage,
      "lastMessageID": lastMessageID,
      "avatarURL": avatarURL,
      "unReadCount": unReadCount,
    };
  }
}
