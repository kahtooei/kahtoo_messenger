class Message {
  int? id;
  String? author;
  String? content;
  String? chat;
  String? send_date;
  String? receive_date;
  String? seen_date;

  Message(
      {this.id,
      this.author,
      this.content,
      this.chat,
      this.send_date,
      this.receive_date = null,
      this.seen_date = null});

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'author': this.author,
      'content': this.content,
      'chat': this.chat,
      'send_date': this.send_date,
      'receive_date': this.receive_date,
      'seen_date': this.seen_date,
    };
  }
}
