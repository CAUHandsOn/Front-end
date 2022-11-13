class User {
  String _id;
  String _name;
  String _email;
  String _password;
  String _role; // student or prof

  User(
      this._id,
      this._name,
      this._email,
      this._password,
      this._role
      );


  User.fromJson(Map<String, dynamic> json)
      : _id = json['id'],
        _name = json['name'],
        _email = json['email'],
        _password = json['password'],
        _role = json['role'];

}