import 'dart:convert';
import 'package:handson/src/model/roomMembers.dart';
import 'package:handson/src/ui/home.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:handson/src/model/classroom.dart';

import '../model/classEntity.dart';
import '../model/classroomEntity.dart';
import '../model/userEntity.dart';
import '../model/user.dart';

class ClassroomProvider extends ChangeNotifier {
  late Classroom _classroomInfo;
  bool is_loaded = false;
  List<UserEntity> _userList = [];
  String _buildingName = '';

  Classroom get classroomInfo => _classroomInfo;
  List<UserEntity> get userList => _userList;
  String get buildingName => _buildingName;

  Future<String> loadJsonFile(context) {
    return Future.value(DefaultAssetBundle.of(context)
        .loadString("assets/json/classroom_response.json"));
  }

  loadClassroomInfo(context) async {
    print("loadClassroomInfo called");
    String data = await loadJsonFile(context);
    print(data);
    final jsonResult = jsonDecode(data);
    _classroomInfo = Classroom.fromJson(jsonResult);
    is_loaded = true;
    notifyListeners();
  }
  getClassroomName(String id) async{
    String url = 'https://bho.ottitor.shop/room/$id';
    http.Response response = await http.get(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json;charset=UTF-8',
        'Authorization': 'Bearer eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiIyMDE4NjI3NCIsIm5hbWUiOiLquYDrqoXsirkiLCJlbWFpbCI6Im1za0BjYXUuYWMua3IiLCJpZCI6IjIwMTg2Mjc0Iiwicm9sZSI6InN0dWRlbnQiLCJhdXRoIjoic3R1ZGVudCIsImV4cCI6MTY3NzY3MzQwNH0.XH4WDfYDU15yqxOenoxd8Gy_8W71D9k9YIrktFN8Iidq6AKFU0oNJv_JVIY1Jifjt3Uaj6k5BBNOwq8LhBiiEA'
        // 'Authorization': 'Bearer $accessToken'
      },
    );
    if (response.statusCode == 200) {
      _buildingName = await jsonDecode(response.body)['data']['name'];
    } else {
      print("오류 발생");
    }
    notifyListeners();
  }

  getClassroomInfo(String id) async {
    String url = 'https://bho.ottitor.shop/room/$id';
    http.Response response = await http.get(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json;charset=UTF-8',
        'Authorization': 'Bearer eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiIyMDE4NjI3NCIsIm5hbWUiOiLquYDrqoXsirkiLCJlbWFpbCI6Im1za0BjYXUuYWMua3IiLCJpZCI6IjIwMTg2Mjc0Iiwicm9sZSI6InN0dWRlbnQiLCJhdXRoIjoic3R1ZGVudCIsImV4cCI6MTY3NzY3MzQwNH0.XH4WDfYDU15yqxOenoxd8Gy_8W71D9k9YIrktFN8Iidq6AKFU0oNJv_JVIY1Jifjt3Uaj6k5BBNOwq8LhBiiEA'
        // 'Authorization': 'Bearer $accessToken'
      },
    );
    if (response.statusCode == 200) {
      _userList = await jsonDecode(response.body)['data']['roomMembers']
          .where((data) => RoomMembers.fromJson(data).user.role == 'student')
          .map<UserEntity>((data) => RoomMembers.fromJson(data).user)
          .toList();
    } else {
      print("오류 발생");
    }
    notifyListeners();
  }

  postEntrance(String roomId, String userId) async {
    String url = 'https://bho.ottitor.shop/room/$roomId';
    http.Response response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json;charset=UTF-8',
        'Authorization': 'Bearer $accessToken',
      },
    );
    if (response.statusCode == 200) {
      print("출입");
    } else {
      print("출입 오류 발생");
    }
    notifyListeners();
  }
}
