import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:handson/src/model/classroom.dart';
import 'package:http/http.dart' as http;

class ClassroomListProvider extends ChangeNotifier{

  List<Classroom> _classroomList = [];
  List<Classroom> get classroomList => _classroomList;

  Future<void> getClassroomList() async {
    String url = 'https://bho.ottitor.shop/room';

    http.Response response = await http.get(
      Uri.parse(url),
    );

    if (response.statusCode == 200){
      _classroomList = jsonDecode(response.body)['data'].map<Classroom>((data) {
        return Classroom.fromJson(data);
      }).toList();
    }
    print(_classroomList);
    notifyListeners();
  }

  Future<String> loadJsonFile(context) {
    print("loading the classroomList file . . . ");
    return Future.value(DefaultAssetBundle.of(context)
        .loadString("assets/json/classroomList_response.json"));
  }

  loadClassroomList(context) async {
    print("loadClassroomList called");
    String data = await loadJsonFile(context);
    print("data = $data");
    _classroomList = jsonDecode(data)['data'].map<Classroom>((data) {
      return Classroom.fromJson(data);
    }).toList();
    print(_classroomList);
    notifyListeners();
  }

}

