import 'dart:convert';
import 'package:handson/src/model/roomMembers.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:handson/src/model/classroom.dart';

import '../model/classEntity.dart';
import '../model/classroomEntity.dart';
import '../model/member.dart';

class ClassroomProvider extends ChangeNotifier {
  late Classroom _classroomInfo;
  bool is_loaded = false;
  List<Member> _memberList = [];
  String _buildingName = '';

  Classroom get classroomInfo => _classroomInfo;
  List<Member> get memberList => _memberList;
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

  getClassroomInfo(String id) async {
    String url = 'https://bho.ottitor.shop/room/$id';
    http.Response response = await http.get(
      Uri.parse(url),
      headers: <String,String>{
        'Content-Type' : 'application/json;charset=UTF-8'
      },
    );
    if (response.statusCode == 200) {
      print('hi ${jsonDecode(response.body)['data']}');
      print('hello ${jsonDecode(response.body)['data']['roomMembers']}');

      _buildingName = await jsonDecode(response.body)['data']['name'];
      _memberList = await jsonDecode(response.body)['data']['roomMembers']
          .where((data) => RoomMembers.fromJson(data).member.role == 'student')
          .map<Member>((data) => RoomMembers.fromJson(data).member)
          .toList();
    }
    else{
      print("오류 발생");
    }
    notifyListeners();
  }

  postEntrance(String id) async {
    String url = 'https://bho.ottitor.shop/room/$id/me';
    http.Response response = await http.post(
      Uri.parse(url),
      headers: <String,String>{
        'Content-Type' : 'application/json;charset=UTF-8',
        'Authorization' : '20182018',
      },
    );
    if (response.statusCode == 200){
      print("출입");
    }
    else{
      print("출입 오류 발생");
    }
    notifyListeners();
  }
}
