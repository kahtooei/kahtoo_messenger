class MyModel {
  int? id;
  String? username;
  String? token;
  String? fullName;
  String? password;
  MyModel({this.id, this.username, this.token, this.fullName, this.password});

  bool isValidate() {
    if (fullName != null &&
        username != null &&
        token != null &&
        password != null) {
      return true;
    }
    return false;
  }
}
