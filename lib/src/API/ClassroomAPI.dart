import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../provider/classroomList_provider.dart';
import '../ui/home.dart';

class ClassroomAPI{

  getClassroomList(context) async {
    String url = 'https://bho.ottitor.shop/room';
    http.Response response = await http.get(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json;charset=UTF-8',
        'Authorization': 'Bearer $accessToken'
      },
    );
    log(jsonDecode(response.body).toString());
    Provider.of<ClassroomListProvider>(context, listen: false).loadClassroomList(response.body);
  }


}