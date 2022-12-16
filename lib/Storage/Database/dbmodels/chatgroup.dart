class ChatGroup {
  int? id;
  String? groupname;
  String? name;

  ChatGroup({this.id, this.groupname, this.name});

  Map<String, dynamic> toMap() {
    return {'id': this.id, 'groupname': this.groupname, 'name': this.name};
  }
}
