import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../../model/classroom.dart';
import '../../provider/classroomList_provider.dart';

class StudentClassroomWidget extends StatefulWidget {
  const StudentClassroomWidget({Key? key}) : super(key: key);

  @override
  State<StudentClassroomWidget> createState() => _StudentClassroomWidgetState();
}

class _StudentClassroomWidgetState extends State<StudentClassroomWidget> {
  late ClassroomListProvider _classroomListProvider;
  late List<Classroom> classroomList;

  Widget _listBody(){
    classroomList = _classroomListProvider.classroomList;
    print(classroomList);
    return ListView(
      scrollDirection: Axis.vertical,
      children: List.generate(100, (i){
        return ListTile(
          leading: const Icon(Icons.home),
          title: Text('Student ${i+1}'),
          trailing: const Icon(Icons.arrow_forward),
          onTap: () {

          },
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    _classroomListProvider = Provider.of<ClassroomListProvider>(context,listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text('강의실 목록'),
      ),
      body: _listBody(),
    );
  }
}
