class ChatUser {
  int? id;
  String? username;
  String? name;

  ChatUser({this.id, this.username, this.name});

  Map<String, dynamic> toMap() {
    return {'id': this.id, 'username': this.username, 'name': this.name};
  }
}
