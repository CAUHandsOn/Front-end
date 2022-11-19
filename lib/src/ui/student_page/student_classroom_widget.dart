import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../../model/classEntity.dart';
import '../../model/classroom.dart';
import '../../provider/classroomList_provider.dart';

class StudentClassroomWidget extends StatefulWidget {
  const StudentClassroomWidget({Key? key}) : super(key: key);

  @override
  State<StudentClassroomWidget> createState() => _StudentClassroomWidgetState();
}

class _StudentClassroomWidgetState extends State<StudentClassroomWidget> {
  late ClassroomListProvider _classroomListProvider;
  late List<ClassEntity> classroomList;


  Widget _listBody(){
    _classroomListProvider.getClassroomList();

    return Consumer<ClassroomListProvider>(
      builder: (context, provider, widget){
        return ListView(
          scrollDirection: Axis.vertical,
          children: List.generate(
              provider.classroomList.length, (i){
            return ListTile(
              title: Text(provider.classroomList[i].name),
              trailing: const Icon(Icons.arrow_forward),
              onTap: () {

              },
            );
          }).toList(),
        );
      },
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
