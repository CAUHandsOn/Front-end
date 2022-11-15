class User {
  String id;
  String name;
  String email;
  String password;
  String role; // student or prof

  User(
      {required this.id,
      required this.name,
      required this.email,
      required this.password,
      required this.role});

  User.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        email = json['email'],
        password = json['password'],
        role = json['role'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['password'] = password;
    data['role'] = role;
    return data;
  }
}
