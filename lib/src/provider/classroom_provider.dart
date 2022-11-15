import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:handson/src/model/classroom.dart';

class ClassroomProvider extends ChangeNotifier {
  late Classroom _classroomInfo;
  bool is_loaded = false;

  Classroom get classroomInfo => _classroomInfo;

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
}