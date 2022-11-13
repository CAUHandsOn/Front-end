import 'student.dart';


class Classroom{
  String _buildingName;
  String _roomNumber;
  int _totalCount;

  String get buildingName => _buildingName;
  String get roomNumber => _roomNumber;
  int get totalCount => _totalCount;
  List<Student> get studentList => _studentList;

  List<Student> _studentList = [];

  Classroom(
      this._buildingName,
      this._roomNumber,
      this._totalCount,
      this._studentList
      );

  Classroom.fromJson(Map<String,dynamic> json):
        _buildingName = json['building_name'] as String,
        _roomNumber = json['room_number'] as String,
        _totalCount = int.parse(json['total_count'] as String),
        _studentList = (json['student_list'] as List<dynamic>).map((item) => Student.fromJson(item)).toList();

}