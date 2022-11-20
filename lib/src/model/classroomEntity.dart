import 'package:handson/src/model/roomMembers.dart';

import 'student.dart';


class ClassroomEntity{
  // String _classroomID;
  // String _classroomName;
  List<RoomMembers> _rommMembers = [];

  // String get classroomID => _classroomID;
  // String get classroomName => _classroomName;
  List<RoomMembers> get rommMembers => _rommMembers;


  ClassroomEntity(
      // this._classroomID,
      // this._classroomName,
      this._rommMembers
      );

  ClassroomEntity.fromJson(Map<String,dynamic> json):
        // _classroomID = json['id'] as String,
        // _classroomName = json['name'] as String,
        _rommMembers = (json['roomMembers'] as List<dynamic>).map((item) => RoomMembers.fromJson(item)).toList();

}