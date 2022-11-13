class Student {
  String _name;
  String _id;

  String get name => _name;

  String get id => _id;

  Student(
    this._name,
    this._id,
  );

  Student.fromJson(Map<String, dynamic> json)
      : _name = json['name'] as String,
        _id = json['id'] as String;
}
