class InfoUser {
  String? email;
  String? name;

  InfoUser({this.email, this.name});

  InfoUser.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    name = json['name'];
  }
}
