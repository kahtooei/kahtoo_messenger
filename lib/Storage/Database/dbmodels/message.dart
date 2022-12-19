class Message {
  int? id;
  int? author;
  String? content;
  int? chatgroup;
  int? receiver;
  String? send_date;
  String? receive_date;
  String? seen_date;

  Message(
      {this.id,
      this.author,
      this.content,
      this.chatgroup,
      this.receiver,
      this.send_date,
      this.receive_date,
      this.seen_date});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'author': author,
      'content': content,
      'chatgroup': chatgroup,
      'receiver': receiver,
      'send_date': send_date,
      'receive_date': receive_date,
      'seen_date': seen_date,
    };
  }
}
