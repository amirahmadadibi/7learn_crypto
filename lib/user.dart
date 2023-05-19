class User {
  int id;
  String name;
  String username;
  String city;
  String phone;

  User(this.id, this.name, this.username, this.city, this.phone);

  factory User.fromJson(Map<String, dynamic> data) {
    return User(data['id'], data['name'], data['username'], data['address']['city'], data['phone']);
  }
}
