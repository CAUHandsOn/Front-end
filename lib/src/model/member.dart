class Member{
  String _id;
  String _name;
  String _role;

  String get id => _id;
  String get name => _name;
  String get role => _role;

  Member(
      this._id,
      this._name,
      this._role
      );

  Member.fromJson(Map<String,dynamic> json):
    _id = json['id'] as String,
    _name = json['name'] as String,
    _role = json['role'] as String;
}