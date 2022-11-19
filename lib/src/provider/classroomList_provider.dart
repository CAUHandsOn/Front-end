import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:handson/src/model/classroom.dart';
import 'package:http/http.dart' as http;

import '../model/classEntity.dart';

class ClassroomListProvider extends ChangeNotifier{

  List<ClassEntity> _classroomList = [];
  List<ClassEntity> get classroomList => _classroomList;

  Future<void> getClassroomList() async {
    String url = 'https://bho.ottitor.shop/room';

    http.Response response = await http.get(
      Uri.parse(url),
      headers: <String,String>{
        'Content-Type' : 'application/json;charset=UTF-8'
      },
    );
    print(response.body);
    if (response.statusCode == 200){
      print(jsonDecode(response.body)['data']);
      _classroomList = await jsonDecode(response.body)['data'].map<ClassEntity>((data) {
        return ClassEntity.fromMap(data);
      }).toList();
    }
    notifyListeners();
  }

  // Future<String> loadJsonFile(context) {
  //   print("loading the classroomList file . . . ");
  //   return Future.value(DefaultAssetBundle.of(context)
  //       .loadString("assets/json/classroomList_response.json"));
  // }
  //
  // loadClassroomList(context) async {
  //   print("loadClassroomList called");
  //   String data = await loadJsonFile(context);
  //   print("data = $data");
  //   _classroomList = jsonDecode(data)['data'].map<Classroom>((data) {
  //     return Classroom.fromJson(data);
  //   }).toList();
  //   print(_classroomList);
  //   notifyListeners();
  // }

// postClassroom(Map<String,dynamic> data) async{
//   String url = 'https://bho.ottitor.shop/room';
//
//   http.Response response = await http.post(
//       Uri.parse(url),
//       headers: <String,String>{
//         'Content-Type' : 'application/json;charset=UTF-8'
//       },
//       body: jsonEncode(data)
//   );
//   if (response.statusCode == 200){
//     print("postClassroom success!");
//     return;
//   } else{
//     throw Exception('Failed to postClassroom');
//   }
// }

}

