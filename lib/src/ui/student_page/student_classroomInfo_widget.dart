import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../provider/classroom_provider.dart';

class ClassroomInfo extends StatefulWidget {
  const ClassroomInfo({Key? key, this.classroomID}) : super(key: key);
  final classroomID;

  @override
  State<ClassroomInfo> createState() => _ClassroomInfoState();
}

class _ClassroomInfoState extends State<ClassroomInfo> {

  Widget _body(String classroomID){
    return Consumer<ClassroomProvider>(
      builder: (context, provider, widget) {
        provider.getClassroomInfo(classroomID);
        return Center(

        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('강의실 정보'),
      ),
      body: _body(widget.classroomID),
    );
  }
}


