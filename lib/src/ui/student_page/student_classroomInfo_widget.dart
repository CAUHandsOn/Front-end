import 'package:flutter/material.dart';
import 'package:handson/src/provider/classroom_provider.dart';

import '../../provider/classroomList_provider.dart';

class ClassroomInfo extends StatefulWidget {
  const ClassroomInfo({Key? key, this.classroomID}) : super(key: key);
  final classroomID;

  @override
  State<ClassroomInfo> createState() => _ClassroomInfoState();
}

class _ClassroomInfoState extends State<ClassroomInfo> {

  Widget _body(String classroomID){
    return Center(
      child: Text(classroomID)
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('강의실 출입 내역'),
      ),
      body: _body(widget.classroomID),
    );
  }
}


