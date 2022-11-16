import 'package:flutter/material.dart';

class StudentClassroomWidget extends StatefulWidget {
  const StudentClassroomWidget({Key? key}) : super(key: key);

  @override
  State<StudentClassroomWidget> createState() => _StudentClassroomWidgetState();
}

class _StudentClassroomWidgetState extends State<StudentClassroomWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('강의실 출입 내역'),
      ),
    );
  }
}
