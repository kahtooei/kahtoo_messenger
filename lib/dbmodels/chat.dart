class Chat {
  int? id;
  String? username;
  String? name;
  int? type;

  Chat({this.id, this.username, this.name, this.type});

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'username': this.username,
      'name': this.name,
      'type': this.type
    };
  }
}
